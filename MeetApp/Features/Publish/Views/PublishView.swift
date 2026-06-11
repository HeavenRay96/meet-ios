import SwiftUI

// MARK: - 发布页
struct PublishView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var contentText = ""
    @State private var selectedType: ContentType = .photo
    @State private var selectedImages: [Int] = []
    @State private var showPublishSuccess = false
    
    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 3)
    
    var body: some View {
        ZStack {
            AppTheme.darkBgStart.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // 图片选择网格
                    LazyVGrid(columns: gridColumns, spacing: 4) {
                        ForEach(0..<5, id: \.self) { index in
                            if index < selectedImages.count {
                                // 已选图片
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(AppTheme.primaryBlue.opacity(0.2))
                                        .frame(height: 105)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .font(.system(size: 24))
                                                .foregroundColor(AppTheme.whiteOpacity03)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(AppTheme.accentOrange, lineWidth: 2)
                                        )
                                    
                                    // ✓ 标记
                                    ZStack {
                                        Circle()
                                            .fill(AppTheme.accentOrange)
                                            .frame(width: 20, height: 20)
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .padding(4)
                                }
                            } else if index == selectedImages.count {
                                // 添加按钮
                                Button(action: {
                                    withAnimation {
                                        selectedImages.append(selectedImages.count)
                                    }
                                }) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                        .fill(AppTheme.whiteOpacity03)
                                        .frame(height: 105)
                                        .overlay(
                                            VStack(spacing: 4) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 24))
                                                Text("添加")
                                                    .font(.system(size: 12))
                                            }
                                                .foregroundColor(AppTheme.whiteOpacity04)
                                        )
                                }
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(AppTheme.whiteOpacity005)
                                    .frame(height: 105)
                            }
                        }
                    }
                    .padding(.horizontal, 33)
                    .padding(.top, 16)
                    
                    // 文字输入框
                    TextEditor(text: $contentText)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(AppTheme.whiteOpacity005)
                        )
                        .frame(height: 80)
                        .padding(.horizontal, 33)
                        .padding(.top, 16)
                        .overlay(alignment: .topLeading) {
                            if contentText.isEmpty {
                                Text("说点什么...")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppTheme.whiteOpacity03)
                                    .padding(.horizontal, 49)
                                    .padding(.top, 28)
                                    .allowsHitTesting(false)
                            }
                        }
                    
                    // 内容类型 Chip
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(ContentType.allCases, id: \.self) { type in
                                Button(action: { selectedType = type }) {
                                    Text("\(type.icon) \(type.rawValue)")
                                        .font(.system(size: 13, weight: selectedType == type ? .medium : .regular))
                                        .foregroundColor(selectedType == type ? .white : AppTheme.whiteOpacity06)
                                        .padding(.horizontal, 16)
                                        .frame(height: 32)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(selectedType == type ? AppTheme.primaryBlue : AppTheme.whiteOpacity008)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 33)
                    }
                    .padding(.top, 16)
                    
                    // 选项行
                    optionRow(icon: "mappin", title: "添加位置")
                    Divider().background(AppTheme.whiteOpacity01).padding(.horizontal, 33)
                    optionRow(icon: "tag", title: "添加标签")
                    Divider().background(AppTheme.whiteOpacity01).padding(.horizontal, 33)
                    optionRow(icon: "clock", title: "定时发布")
                    
                    // 发布按钮
                    Button(action: {
                        showPublishSuccess = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    }) {
                        Text("发布")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                LinearGradient(
                                    colors: [AppTheme.primaryBlue, AppTheme.primaryBlueLight],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .clipShape(Capsule())
                            )
                            .shadow(color: AppTheme.primaryBlue.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 33)
                    .padding(.top, 24)
                }
            }
            
            // 发布成功提示
            if showPublishSuccess {
                VStack {
                    Spacer()
                    Text("✅ 发布成功！")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(AppTheme.primaryBlue)
                        )
                        .transition(.scale.combined(with: .opacity))
                    Spacer().frame(height: 200)
                }
                .animation(.spring(), value: showPublishSuccess)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Text("取消")
                        .font(.system(size: 15))
                        .foregroundColor(AppTheme.whiteOpacity07)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("发布")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showPublishSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                    }
                }) {
                    Text("发布")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(AppTheme.primaryBlue)
                }
            }
        }
    }
    
    private func optionRow(icon: String, title: String) -> some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.whiteOpacity05)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(AppTheme.whiteOpacity07)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.whiteOpacity03)
            }
            .padding(.horizontal, 33)
            .frame(height: 44)
        }
    }
}

#Preview {
    NavigationStack {
        PublishView()
    }
    .preferredColorScheme(.dark)
}
