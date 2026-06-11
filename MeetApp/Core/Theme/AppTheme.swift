import SwiftUI

// MARK: - 品牌色彩体系（暗色系）
struct AppTheme {
    // 品牌色
    static let primaryBlue = Color(red: 74/255, green: 144/255, blue: 164/255) // #4A90A4
    static let primaryBlueDark = Color(red: 58/255, green: 122/255, blue: 142/255) // #3A7A8E
    static let primaryBlueLight = Color(red: 100/255, green: 160/255, blue: 180/255) // #5BA0B4
    
    // 暗色系背景
    static let darkBgStart = Color(red: 15/255, green: 26/255, blue: 46/255) // #0F1A2E
    static let darkBgEnd = Color(red: 26/255, green: 45/255, blue: 61/255) // #1A2D3D
    
    // 功能色
    static let accentOrange = Color(red: 255/255, green: 107/255, blue: 53/255) // #FF6B35
    
    // 白色半透明
    static let whiteFull = Color.white
    static let whiteOpacity08 = Color.white.opacity(0.8)
    static let whiteOpacity07 = Color.white.opacity(0.7)
    static let whiteOpacity06 = Color.white.opacity(0.6)
    static let whiteOpacity05 = Color.white.opacity(0.5)
    static let whiteOpacity04 = Color.white.opacity(0.4)
    static let whiteOpacity03 = Color.white.opacity(0.3)
    static let whiteOpacity02 = Color.white.opacity(0.2)
    static let whiteOpacity012 = Color.white.opacity(0.12)
    static let whiteOpacity01 = Color.white.opacity(0.1)
    static let whiteOpacity008 = Color.white.opacity(0.08)
    static let whiteOpacity005 = Color.white.opacity(0.05)
    
    // 组件背景
    static let cardBackground = Color.white.opacity(0.1)
    static let inputBackground = Color.white.opacity(0.08)
    static let inputBackgroundFocus = Color.white.opacity(0.12)
    static let tabBarBackground = Color(red: 15/255, green: 26/255, blue: 46/255).opacity(0.95)
    static let mapBackground = Color(red: 13/255, green: 21/255, blue: 32/255)
}

// MARK: - 渐变背景
struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [AppTheme.darkBgStart, AppTheme.darkBgEnd]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
