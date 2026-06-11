import SwiftUI

@main
struct MeetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

// MARK: - 根视图（含自定义Tab导航）
struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showPublish = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                DiscoverView()
                    .tag(0)
                DynamicListView()
                    .tag(1)
                Color.clear
                    .tag(2)
                FavoritesView()
                    .tag(3)
                ProfileView()
                    .tag(4)
            }
            .ignoresSafeArea(.keyboard)
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: selectedTab) { _, newValue in
            if newValue == 2 {
                showPublish = true
                selectedTab = 0 // 回到发现页
            }
        }
        .fullScreenCover(isPresented: $showPublish) {
            NavigationStack {
                PublishView()
            }
        }
    }
}
