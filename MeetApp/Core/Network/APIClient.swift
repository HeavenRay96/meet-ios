import Foundation

// MARK: - API 客户端（MVP 阶段使用 Mock 数据）
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

class APIClient {
    static let shared = APIClient()
    
    private let baseURL = "https://api.meet.app/api/v1"
    private let isMockMode = true
    
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
    func request<T: Decodable>(
        method: String = "GET",
        path: String,
        body: [String: Any]? = nil,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> T {
        if isMockMode {
            throw APIError.serverError("Mock模式 - API未实现")
        }
        
        guard var components = URLComponents(string: "\(baseURL)\(path)") else {
            throw APIError.invalidURL
        }
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("无效响应")
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.serverError("状态码: \(httpResponse.statusCode)")
        }
    }
}
