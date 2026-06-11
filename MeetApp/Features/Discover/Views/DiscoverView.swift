import SwiftUI

// MARK: - 发现页
struct DiscoverView: View {
    @State private var searchText = ""
    @State private var selectedPost: TravelPost?
    @State private var showDetail = false
    @State private var showNewBanner = true
    @State private var isEmpty = false
    @State private var floatingCardClosed = false
    @State private var navigateToPublish = false
    
    private let hotPost = MockData.hotPost
    private let activeCount = 12
    private let activeAvatars = MockData.activeUserAvatars
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 地图背景
                MapView(posts: MockData.posts, onPinTap: { post in
                    selectedPost = post
                    showDetail = true
                })
                
                // 搜索栏
                VStack(spacing: 0) {
                    Spacer().frame(height: 59)
                    
                    SearchBar(text: $searchText)
                    
                    Spacer()
                }
                
                // 热门区域
                VStack(spacing: 0) {
                    Spacer().frame(height: 107)
                    
                    HStack {
                        Spacer()
                        HotAreaView(activeCount: activeCount, avatarURLs: activeAvatars)
                            .padding(.trailing, 16)
                    }
                    
                    Spacer()
                }
                
                // 新动态提示
                if showNewBanner {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 115)
                        NewContentBanner(count: 3) {
                            showNewBanner = false
                        }
                        Spacer()
                    }
                }
                
                // 空状态
                if isEmpty {
                    EmptyStateView {
                        navigateToPublish = true
                    }
                }
                
                // 定位按钮
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .fill(AppTheme.whiteOpacity012)
                                )
                        }
                        .padding(.trailing, 16)
                        .padding(.bottom, 120)
                    }
                }
                
                // 底部浮卡
                if !floatingCardClosed && !isEmpty {
                    VStack(spacing: 0) {
                        Spacer()
                        FloatingCard(post: hotPost, onClose: {
                            floatingCardClosed = true
                        }, onTap: {
                            selectedPost = hotPost
                            showDetail = true
                        })
                        .padding(.bottom, 80)
                    }
                }
            }
            .background(AppTheme.mapBackground)
            .navigationDestination(isPresented: $showDetail) {
                if let post = selectedPost {
                    PinDetailView(post: post)
                }
            }
            .navigationDestination(isPresented: $navigateToPublish) {
                PublishView()
            }
        }
    }
}

#Preview {
    DiscoverView()
        .preferredColorScheme(.dark)
}
