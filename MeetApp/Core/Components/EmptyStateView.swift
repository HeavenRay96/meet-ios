import SwiftUI

// MARK: - 空状态
struct EmptyStateView: View {
    var onPublish: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "map")
                .font(.system(size: 64))
                .foregroundColor(AppTheme.whiteOpacity03)
            
            Text("该区域还没有分享")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppTheme.whiteOpacity07)
            
            Text("还没有人在附近发布内容，\n成为第一个分享的人吧！")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.whiteOpacity04)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
            
            Button(action: { onPublish?() }) {
                Text("📸 发布第一条动态")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 160, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.primaryBlue)
                    )
            }
            .padding(.top, 8)
            
            Spacer()
        }
    }
}

#Preview {
    EmptyStateView()
        .background(AppTheme.darkBgStart)
        .preferredColorScheme(.dark)
}
