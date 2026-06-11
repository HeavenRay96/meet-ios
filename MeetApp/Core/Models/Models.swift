import Foundation

// MARK: - 用户模型
struct MeetUser: Identifiable, Codable, Equatable {
    let id: Int
    var nickname: String
    var avatarURL: String
    var bio: String
    var travelCount: Int
    var followerCount: Int
    var followingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, nickname
        case avatarURL = "avatar_url"
        case bio
        case travelCount = "travel_count"
        case followerCount = "follower_count"
        case followingCount = "following_count"
    }
}

// MARK: - 帖子模型
struct TravelPost: Identifiable, Codable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let content: String
    let location: String
    let coverURL: String
    let imageURLs: [String]
    let likeCount: Int
    let commentCount: Int
    let createdAt: String
    let user: MeetUser
    var isLiked: Bool
    var isBookmarked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title, content, location
        case coverURL = "cover_url"
        case imageURLs = "image_urls"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case createdAt = "created_at"
        case user, isLiked, isBookmarked
    }
    
    var distance: String {
        let km = Double(Int.random(in: 1...50)) + Double(Int.random(in: 0...9)) / 10.0
        return String(format: "%.1fkm", km)
    }
    
    var tags: [String] {
        ["#日落", "#海岸线", "#旅行"]
    }
    
    var relativeTime: String {
        let hours = Int.random(in: 1...48)
        if hours < 1 { return "刚刚" }
        if hours < 24 { return "\(hours)小时前" }
        return "\(hours / 24)天前"
    }
}

// MARK: - 评论模型
struct Comment: Identifiable, Equatable {
    let id: Int
    let user: MeetUser
    let content: String
    let createdAt: String
    
    var relativeTime: String {
        let hours = Int.random(in: 1...24)
        if hours < 1 { return "刚刚" }
        return "\(hours)小时前"
    }
}

// MARK: - 内容类型
enum ContentType: String, CaseIterable {
    case photo = "摄影"
    case video = "视频"
    case text = "文字"
    case checkin = "打卡"
    
    var icon: String {
        switch self {
        case .photo: return "📸"
        case .video: return "🎬"
        case .text: return "✏️"
        case .checkin: return "📍"
        }
    }
}
