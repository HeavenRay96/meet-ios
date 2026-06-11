import SwiftUI

// MARK: - 收藏（占位）
struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()
                
                Image(systemName: "heart")
                    .font(.system(size: 48))
                    .foregroundColor(AppTheme.whiteOpacity03)
                
                Text("收藏")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(AppTheme.whiteOpacity06)
                
                Text("收藏的内容将在这里展示")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.whiteOpacity04)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(AppTheme.darkBgStart)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("收藏")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .preferredColorScheme(.dark)
}
