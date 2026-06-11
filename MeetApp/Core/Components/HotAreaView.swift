import SwiftUI

// MARK: - 热门区域
struct HotAreaView: View {
    let activeCount: Int
    let avatarURLs: [String]
    
    var body: some View {
        HStack(spacing: 6) {
            Text("🔥")
                .font(.system(size: 12))
            
            // 重叠头像
            ZStack {
                ForEach(Array(avatarURLs.prefix(3).enumerated()), id: \.offset) { index, url in
                    AsyncImage(url: URL(string: url)) { phase in
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
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(AppTheme.darkBgStart, lineWidth: 1.5)
                    )
                    .offset(x: CGFloat(index) * -10)
                }
            }
            .frame(width: CGFloat(min(avatarURLs.count, 3)) * 14 + 10, alignment: .leading)
            
            Text("\(activeCount) 人正在这里活跃")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 10)
        .frame(height: 28)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(AppTheme.whiteOpacity008)
        )
    }
}

#Preview {
    HotAreaView(activeCount: 12, avatarURLs: MockData.activeUserAvatars)
        .background(AppTheme.darkBgStart)
        .preferredColorScheme(.dark)
}
