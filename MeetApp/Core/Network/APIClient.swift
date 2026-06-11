import Foundation

// MARK: - API 错误码（与后端对齐）
enum APIError: LocalizedError {
    case invalidURL
    case noData
    case unauthorized
    case serverError(String)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "无效的URL"
        case .noData: return "无数据"
        case .unauthorized: return "未授权"
        case .serverError(let msg): return msg
        case .decodingError: return "数据解析失败"
        }
    }
}

// MARK: - 统一响应结构（与后端对齐）
struct APIResponse<T: Decodable>: Decodable {
    let code: Int
    let message: String
    let data: T?
    let requestID: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message, data
        case requestID = "request_id"
    }
}

// MARK: - API 端点定义（与后端路由完全对齐）
enum APIEndpoint {
    // 认证 - /api/v1/auth/*
    case sendCode(phone: String, scene: String)
    case loginByCode(phone: String, code: String)
    case loginByPassword(phone: String, password: String)
    case register(phone: String, code: String, password: String, nickname: String)
    case verifyResetCode(phone: String, code: String)
    case resetPassword(resetToken: String, newPassword: String)
    case refreshToken(refreshToken: String)
    case logout
    
    // 用户 - /api/v1/user/*
    case getProfile
    case updateProfile(nickname: String?, bio: String?, gender: Int32?, birthday: String?)
    case changePassword(oldPassword: String, newPassword: String)
    
    // 旅行内容 - /api/v1/travel/*
    case listPosts(page: Int, pageSize: Int)
    case getPost(postId: Int64)
    case createPost(title: String, content: String, location: String)
    case deletePost(postId: Int64)
    
    var method: String {
        switch self {
        case .getProfile, .listPosts, .getPost:
            return "GET"
        case .updateProfile:
            return "PUT"
        case .deletePost:
            return "DELETE"
        default:
            return "POST"
        }
    }
    
    var path: String {
        switch self {
        case .sendCode: return "/api/v1/auth/send-code"
        case .loginByCode: return "/api/v1/auth/login/code"
        case .loginByPassword: return "/api/v1/auth/login/password"
        case .register: return "/api/v1/auth/register"
        case .verifyResetCode: return "/api/v1/auth/forgot-password/verify"
        case .resetPassword: return "/api/v1/auth/forgot-password/reset"
        case .refreshToken: return "/api/v1/auth/refresh"
        case .logout: return "/api/v1/auth/logout"
        case .getProfile: return "/api/v1/user/profile"
        case .updateProfile: return "/api/v1/user/profile"
        case .changePassword: return "/api/v1/user/change-password"
        case .listPosts: return "/api/v1/travel/posts"
        case .getPost(let id): return "/api/v1/travel/posts/\(id)"
        case .createPost: return "/api/v1/travel/posts"
        case .deletePost(let id): return "/api/v1/travel/posts/\(id)"
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .sendCode(let phone, let scene):
            return ["phone": phone, "scene": scene]
        case .loginByCode(let phone, let code):
            return ["phone": phone, "code": code]
        case .loginByPassword(let phone, let password):
            return ["phone": phone, "password": password]
        case .register(let phone, let code, let password, let nickname):
            return ["phone": phone, "code": code, "password": password, "nickname": nickname]
        case .verifyResetCode(let phone, let code):
            return ["phone": phone, "code": code]
        case .resetPassword(let resetToken, let newPassword):
            return ["reset_token": resetToken, "new_password": newPassword]
        case .refreshToken(let refreshToken):
            return ["refresh_token": refreshToken]
        case .updateProfile(let nickname, let bio, let gender, let birthday):
            var body: [String: Any] = [:]
            if let n = nickname { body["nickname"] = n }
            if let b = bio { body["bio"] = b }
            if let g = gender { body["gender"] = g }
            if let bd = birthday { body["birthday"] = bd }
            return body.isEmpty ? nil : body
        case .changePassword(let oldPassword, let newPassword):
            return ["old_password": oldPassword, "new_password": newPassword]
        case .createPost(let title, let content, let location):
            return ["title": title, "content": content, "location": location]
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .listPosts(let page, let pageSize):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "page_size", value: "\(pageSize)")
            ]
        default:
            return nil
        }
    }
}

// MARK: - API 客户端
class APIClient {
    static let shared = APIClient()
    
    // 后端服务地址（腾讯云服务器，Nginx代理到api-gateway:8080）
    private let baseURL = "http://124.223.114.103"
    private let isMockMode = true // MVP阶段使用Mock数据
    
    private var accessToken: String?
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()
    
    private init() {}
    
    func setToken(_ token: String) {
        accessToken = token
    }
    
    func clearToken() {
        accessToken = nil
    }
    
    // MARK: - 通用请求
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        if isMockMode {
            throw APIError.serverError("Mock模式 - 后端API未部署时使用Mock数据")
        }
        
        guard let url = URL(string: "\(baseURL)\(endpoint.path)") else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("无效响应")
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            // 尝试解析为统一响应格式
            if let apiResponse = try? decoder.decode(APIResponse<T>.self, from: data),
               let result = apiResponse.data {
                return result
            }
            // 直接解析
            return try decoder.decode(T.self, from: data)
        case 401:
            throw APIError.unauthorized
        default:
            if let errorData = try? JSONDecoder().decode(APIResponse<String>.self, from: data) {
                throw APIError.serverError(errorData.message)
            }
            throw APIError.serverError("状态码: \(httpResponse.statusCode)")
        }
    }
}
