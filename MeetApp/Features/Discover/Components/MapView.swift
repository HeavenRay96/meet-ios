import SwiftUI

// MARK: - 地图视图（Mock）
struct MapView: View {
    let posts: [TravelPost]
    var onPinTap: ((TravelPost) -> Void)?
    
    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    // 随机Pin位置
    private let pinPositions: [CGPoint] = {
        let positions: [(CGFloat, CGFloat)] = [
            (0.15, 0.2), (0.3, 0.35), (0.5, 0.15), (0.7, 0.3), (0.85, 0.4),
            (0.2, 0.55), (0.45, 0.5), (0.65, 0.6), (0.8, 0.7), (0.35, 0.75),
            (0.55, 0.8), (0.1, 0.7), (0.75, 0.45), (0.4, 0.3), (0.9, 0.55),
        ]
        return positions.map { CGPoint(x: $0.0, y: $0.1) }
    }()
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                // 背景
                AppTheme.mapBackground
                
                // 网格线
                Canvas { context, _ in
                    let gridColor = AppTheme.whiteOpacity005
                    
                    // 水平线
                    for i in 0..<20 {
                        let y = size.height * CGFloat(i) / 20
                        var path = Path()
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: size.width, y: y))
                        context.stroke(path, with: .color(gridColor), lineWidth: 0.5)
                    }
                    
                    // 垂直线
                    for i in 0..<10 {
                        let x = size.width * CGFloat(i) / 10
                        var path = Path()
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                        context.stroke(path, with: .color(gridColor), lineWidth: 0.5)
                    }
                    
                    // 道路（Mock）
                    let roadColor = AppTheme.whiteOpacity02
                    var road1 = Path()
                    road1.move(to: CGPoint(x: 0, y: size.height * 0.3))
                    road1.addCurve(to: CGPoint(x: size.width, y: size.height * 0.5),
                                   control1: CGPoint(x: size.width * 0.3, y: size.height * 0.2),
                                   control2: CGPoint(x: size.width * 0.6, y: size.height * 0.6))
                    context.stroke(road1, with: .color(roadColor), lineWidth: 2)
                    
                    var road2 = Path()
                    road2.move(to: CGPoint(x: size.width * 0.2, y: 0))
                    road2.addCurve(to: CGPoint(x: size.width * 0.8, y: size.height),
                                   control1: CGPoint(x: size.width * 0.4, y: size.height * 0.3),
                                   control2: CGPoint(x: size.width * 0.6, y: size.height * 0.7))
                    context.stroke(road2, with: .color(roadColor), lineWidth: 1.5)
                }
                
                // Pin标注
                ForEach(Array(posts.prefix(min(posts.count, pinPositions.count)).enumerated()), id: \.offset) { index, post in
                    let pos = pinPositions[index]
                    PinAnnotation(
                        avatarURL: post.user.avatarURL,
                        isPulsing: index == 0
                    ) {
                        onPinTap?(post)
                    }
                    .position(
                        x: size.width * pos.x,
                        y: size.height * pos.y
                    )
                }
            }
            .offset(x: offset.width, y: offset.height)
            .scaleEffect(scale)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation(.interactiveSpring()) {
                            offset = .zero
                        }
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let delta = value / lastScale
                        lastScale = value
                        scale = min(max(scale * delta, 0.5), 3.0)
                    }
                    .onEnded { _ in
                        lastScale = 1.0
                    }
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MapView(posts: MockData.posts)
        .preferredColorScheme(.dark)
}
