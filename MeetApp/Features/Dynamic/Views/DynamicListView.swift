import SwiftUI

// MARK: - 动态列表（占位）
struct DynamicListView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()
                
                Image(systemName: "list.bullet")
                    .font(.system(size: 48))
                    .foregroundColor(AppTheme.whiteOpacity03)
                
                Text("动态")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(AppTheme.whiteOpacity06)
                
                Text("关注的人的动态将在这里展示")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.whiteOpacity04)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(AppTheme.darkBgStart)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("动态")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    DynamicListView()
        .preferredColorScheme(.dark)
}
