import SwiftUI

// MARK: - 底部 Tab 导航
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    private let tabItems: [(icon: String, selectedIcon: String, label: String)] = [
        ("house", "house.fill", "发现"),
        ("list.bullet", "list.bullet", "动态"),
        ("plus", "plus", ""),
        ("heart", "heart", "收藏"),
        ("person", "person.fill", "我的"),
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                if index == 2 {
                    // 中间发布按钮
                    Button(action: { selectedTab = index }) {
                        ZStack {
                            LinearGradient(
                                colors: [AppTheme.primaryBlue, AppTheme.primaryBlueLight],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .shadow(color: AppTheme.primaryBlue.opacity(0.4), radius: 8, x: 0, y: 4)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: -12)
                    .frame(maxWidth: .infinity)
                } else {
                    Button(action: { selectedTab = index }) {
                        VStack(spacing: 4) {
                            Image(systemName: selectedTab == index ? tabItems[index].selectedIcon : tabItems[index].icon)
                                .font(.system(size: 22))
                                .foregroundColor(selectedTab == index ? AppTheme.primaryBlue : AppTheme.whiteOpacity04)
                            
                            Text(tabItems[index].label)
                                .font(.system(size: 10))
                                .foregroundColor(selectedTab == index ? AppTheme.primaryBlue : AppTheme.whiteOpacity04)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 34)
        .background(
            AppTheme.tabBarBackground
        )
        .overlay(alignment: .top) {
            Rectangle()
                .fill(AppTheme.whiteOpacity01)
                .frame(height: 0.5)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(0))
    }
    .background(AppTheme.darkBgStart)
    .preferredColorScheme(.dark)
}
