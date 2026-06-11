import SwiftUI

// MARK: - 我的页面
struct ProfileView: View {
    private let user = MockData.users[0]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // 头像
                    AsyncImage(url: URL(string: user.avatarURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        default:
                            Circle()
                                .fill(AppTheme.primaryBlue.opacity(0.3))
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(AppTheme.whiteOpacity015, lineWidth: 2)
                    )
                    .padding(.top, 40)
                    
                    // 昵称
                    Text(user.nickname)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                    
                    // 简介
                    Text(user.bio)
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.whiteOpacity06)
                        .padding(.top, 4)
                    
                    // 编辑按钮
                    Button(action: {}) {
                        Text("编辑资料")
                            .font(.system(size: 13))
                            .foregroundColor(AppTheme.whiteOpacity07)
                            .frame(width: 80, height: 28)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(AppTheme.whiteOpacity03, lineWidth: 1)
                            )
                    }
                    .padding(.top, 12)
                    
                    // 统计数据
                    HStack(spacing: 0) {
                        statItem(value: "\(user.travelCount)", label: "发布")
                        statItem(value: "\(user.followerCount)", label: "粉丝")
                        statItem(value: "\(user.followingCount)", label: "关注")
                    }
                    .padding(.top, 24)
                    
                    // 分割线
                    Divider()
                        .background(AppTheme.whiteOpacity01)
                        .padding(.horizontal, 33)
                        .padding(.top, 20)
                    
                    // 功能入口
                    VStack(spacing: 0) {
                        menuItem(icon: "list.bullet", title: "我的动态", count: "\(user.travelCount)")
                        Divider().background(AppTheme.whiteOpacity01).padding(.leading, 69)
                        menuItem(icon: "heart", title: "收藏", count: "18")
                        Divider().background(AppTheme.whiteOpacity01).padding(.leading, 69)
                        menuItem(icon: "mappin.and.ellipse", title: "我的足迹", count: nil)
                        Divider().background(AppTheme.whiteOpacity01).padding(.leading, 69)
                        menuItem(icon: "hand.thumbsup", title: "赞过的", count: nil)
                        Divider().background(AppTheme.whiteOpacity01).padding(.leading, 69)
                        menuItemWithBadge(icon: "bell", title: "消息通知", hasBadge: true)
                    }
                    .padding(.top, 8)
                }
            }
            .background(AppTheme.darkBgStart)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("我的")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 20))
                            .foregroundColor(AppTheme.whiteOpacity06)
                    }
                }
            }
        }
    }
    
    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(AppTheme.whiteOpacity05)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func menuItem(icon: String, title: String, count: String?) -> some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(AppTheme.whiteOpacity06)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                
                Spacer()
                
                if let count = count {
                    Text(count)
                        .font(.system(size: 15))
                        .foregroundColor(AppTheme.whiteOpacity04)
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.whiteOpacity03)
            }
            .padding(.horizontal, 33)
            .frame(height: 48)
        }
    }
    
    private func menuItemWithBadge(icon: String, title: String, hasBadge: Bool) -> some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(AppTheme.whiteOpacity06)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                
                Spacer()
                
                if hasBadge {
                    Circle()
                        .fill(AppTheme.accentOrange)
                        .frame(width: 8, height: 8)
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.whiteOpacity03)
            }
            .padding(.horizontal, 33)
            .frame(height: 48)
        }
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
