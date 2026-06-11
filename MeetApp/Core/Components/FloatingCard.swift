import SwiftUI

// MARK: - 动态浮卡
struct FloatingCard: View {
    let post: TravelPost
    var onClose: (() -> Void)?
    var onTap: (() -> Void)?
    
    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: 12) {
                // 左侧缩略图
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: post.coverURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(_):
                            Rectangle()
                                .fill(AppTheme.primaryBlue.opacity(0.3))
                                .overlay(Image(systemName: "photo").foregroundColor(AppTheme.whiteOpacity04))
                        case .empty:
                            Rectangle()
                                .fill(AppTheme.inputBackground)
                                .overlay(ProgressView())
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    // 类型标签
                    Text("📸")
                        .font(.system(size: 10))
                        .frame(width: 24, height: 18)
                        .background(AppTheme.primaryBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(2)
                }
                
                // 右侧内容
                VStack(alignment: .leading, spacing: 4) {
                    Text("@\(post.user.nickname)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text(post.content)
                        .font(.system(size: 13))
                        .foregroundColor(AppTheme.whiteOpacity07)
                        .lineLimit(1)
                    
                    HStack(spacing: 8) {
                        Text("\(post.location) · \(post.distance)")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.whiteOpacity05)
                        
                        Spacer()
                        
                        HStack(spacing: 6) {
                            HStack(spacing: 2) {
                                Image(systemName: "heart")
                                    .font(.system(size: 10))
                                Text("\(post.likeCount)")
                            }
                            HStack(spacing: 2) {
                                Image(systemName: "message")
                                    .font(.system(size: 10))
                                Text("\(post.commentCount)")
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.whiteOpacity05)
                    }
                }
            }
            .padding(12)
            .frame(width: 327, height: 88, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.cardBackground)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.whiteOpacity008, lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: -4)
        }
        .buttonStyle(PlainButtonStyle())
        .overlay(alignment: .topTrailing) {
            Button(action: { onClose?() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(AppTheme.whiteOpacity04)
                    .frame(width: 24, height: 24)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.3))
                    )
            }
            .offset(x: -4, y: 4)
        }
    }
}

#Preview {
    FloatingCard(post: MockData.posts[0])
        .background(AppTheme.darkBgStart)
        .preferredColorScheme(.dark)
}
