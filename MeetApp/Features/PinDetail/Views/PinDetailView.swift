import SwiftUI

// MARK: - Pin 详情页
struct PinDetailView: View {
    let post: TravelPost
    @Environment(\.dismiss) private var dismiss
    @State private var isLiked: Bool
    @State private var isBookmarked: Bool
    @State private var isFollowing = false
    @State private var commentText = ""
    @State private var comments: [Comment]
    
    init(post: TravelPost) {
        self.post = post
        _isLiked = State(initialValue: post.isLiked)
        _isBookmarked = State(initialValue: post.isBookmarked)
        _comments = State(initialValue: MockData.comments(for: post.id))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    // 顶部大图
                    ZStack(alignment: .top) {
                        AsyncImage(url: URL(string: post.coverURL)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            default:
                                Rectangle()
                                    .fill(AppTheme.primaryBlue.opacity(0.3))
                                    .overlay(ProgressView())
                            }
                        }
                        .frame(height: 300)
                        .clipped()
                        
                        // 顶部渐变
                        LinearGradient(
                            colors: [.black.opacity(0.4), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 88)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // 发布者信息
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: post.user.avatarURL)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                default:
                                    Circle()
                                        .fill(AppTheme.primaryBlue.opacity(0.3))
                                }
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                HStack {
                                    Text("@\(post.user.nickname)")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text("· \(post.location)")
                                        .font(.system(size: 13))
                                        .foregroundColor(AppTheme.whiteOpacity05)
                                }
                                Text(post.relativeTime)
                                    .font(.system(size: 13))
                                    .foregroundColor(AppTheme.whiteOpacity04)
                            }
                            
                            Spacer()
                            
                            Button(action: { isFollowing.toggle() }) {
                                Text(isFollowing ? "已关注" : "+ 关注")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(isFollowing ? AppTheme.whiteOpacity06 : .white)
                                    .frame(width: 64, height: 28)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(isFollowing ? Color.clear : AppTheme.primaryBlue)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(isFollowing ? AppTheme.whiteOpacity03 : Color.clear, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
                        // 内容描述
                        Text(post.content)
                            .font(.system(size: 15))
                            .foregroundColor(AppTheme.whiteOpacity08)
                            .lineSpacing(6)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        
                        // 标签
                        HStack(spacing: 8) {
                            ForEach(post.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 13))
                                    .foregroundColor(AppTheme.primaryBlue)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        
                        // 位置
                        HStack(spacing: 6) {
                            Image(systemName: "mappin")
                                .font(.system(size: 14))
                            Text(post.location)
                                .font(.system(size: 13))
                        }
                        .foregroundColor(AppTheme.whiteOpacity06)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        
                        // 分割线
                        Divider()
                            .background(AppTheme.whiteOpacity01)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        
                        // 互动按钮行
                        HStack(spacing: 0) {
                            interactionButton(icon: isLiked ? "heart.fill" : "heart", count: post.likeCount + (isLiked ? 1 : 0), isActive: isLiked, activeColor: AppTheme.accentOrange) {
                                isLiked.toggle()
                            }
                            interactionButton(icon: "message", count: post.commentCount, isActive: false, activeColor: nil) {}
                            interactionButton(icon: "square.and.arrow.up", count: nil, isActive: false, activeColor: nil) {}
                            interactionButton(icon: isBookmarked ? "bookmark.fill" : "bookmark", count: nil, isActive: isBookmarked, activeColor: AppTheme.primaryBlue) {
                                isBookmarked.toggle()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        
                        // 评论标题
                        Text("评论")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppTheme.whiteOpacity06)
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                            .padding(.bottom, 12)
                        
                        // 评论列表
                        ForEach(comments) { comment in
                            commentRow(comment)
                        }
                        
                        // 底部间距
                        Spacer().frame(height: 60)
                    }
                }
            }
            
            // 导航栏覆盖
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.3))
                        )
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 59)
        }
        .ignoresSafeArea()
        .background(AppTheme.darkBgStart)
        .navigationBarHidden(true)
        .overlay(alignment: .bottom) {
            // 底部评论输入框
            HStack(spacing: 8) {
                TextField("说点什么...", text: $commentText)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .tint(AppTheme.primaryBlue)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.inputBackground)
                    )
                
                Button(action: {
                    guard !commentText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    let newComment = Comment(
                        id: comments.count + 1,
                        user: MockData.users[0],
                        content: commentText,
                        createdAt: "刚刚"
                    )
                    comments.append(newComment)
                    commentText = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(AppTheme.primaryBlue)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 34)
            .padding(.top, 8)
            .background(AppTheme.darkBgStart)
        }
    }
    
    private func interactionButton(icon: String, count: Int?, isActive: Bool, activeColor: Color?, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                if let count = count {
                    Text("\(count)")
                        .font(.system(size: 12))
                }
            }
            .foregroundColor(isActive ? (activeColor ?? AppTheme.whiteOpacity06) : AppTheme.whiteOpacity06)
            .frame(maxWidth: .infinity)
        }
    }
    
    private func commentRow(_ comment: Comment) -> some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: comment.user.avatarURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                default:
                    Circle()
                        .fill(AppTheme.primaryBlue.opacity(0.3))
                }
            }
            .frame(width: 28, height: 28)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text("@\(comment.user.nickname)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                    Text(comment.relativeTime)
                        .font(.system(size: 11))
                        .foregroundColor(AppTheme.whiteOpacity04)
                }
                Text(comment.content)
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.whiteOpacity07)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    PinDetailView(post: MockData.posts[0])
        .preferredColorScheme(.dark)
}
