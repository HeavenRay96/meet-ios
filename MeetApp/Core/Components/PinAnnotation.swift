import SwiftUI

// MARK: - 地图 Pin 标注
struct PinAnnotation: View {
    let avatarURL: String
    let isPulsing: Bool
    var onTap: (() -> Void)?
    
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        Button(action: { onTap?() }) {
            ZStack {
                // 脉冲动画环
                if isPulsing {
                    Circle()
                        .stroke(AppTheme.primaryBlue.opacity(0.3), lineWidth: 2)
                        .frame(width: 52, height: 52)
                        .scaleEffect(pulseScale)
                        .opacity(2 - pulseScale)
                }
                
                // 外圈
                Circle()
                    .stroke(AppTheme.primaryBlue, lineWidth: 2)
                    .frame(width: 36, height: 36)
                
                // 头像
                AsyncImage(url: URL(string: avatarURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    default:
                        Circle()
                            .fill(AppTheme.primaryBlue.opacity(0.5))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            )
                    }
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if isPulsing {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                    pulseScale = 1.5
                }
            }
        }
    }
}

#Preview {
    PinAnnotation(avatarURL: MockData.users[0].avatarURL, isPulsing: true)
        .background(AppTheme.darkBgStart)
        .preferredColorScheme(.dark)
}
