import SwiftUI

// MARK: - 新动态提示条
struct NewContentBanner: View {
    let count: Int
    var onTap: (() -> Void)?
    
    @State private var offset: CGFloat = -60
    @State private var opacity: Double = 0
    @State private var isShowing = true
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3)) {
                offset = -60
                opacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                onTap?()
            }
        }) {
            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 14))
                
                Text("附近有 \(count) 条新动态")
                    .font(.system(size: 13, weight: .medium))
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .frame(height: 36)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppTheme.accentOrange)
            )
            .shadow(color: AppTheme.accentOrange.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
        .offset(y: offset)
        .opacity(opacity)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                offset = 0
                opacity = 1
            }
            // 5秒后自动消失
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.easeOut(duration: 0.3)) {
                    offset = -60
                    opacity = 0
                }
            }
        }
    }
}

#Preview {
    NewContentBanner(count: 3)
        .background(AppTheme.darkBgStart)
        .preferredColorScheme(.dark)
}
