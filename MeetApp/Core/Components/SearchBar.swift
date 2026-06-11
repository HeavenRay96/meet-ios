import SwiftUI

// MARK: - 搜索栏
struct SearchBar: View {
    @Binding var text: String
    var onFilter: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 15))
                    .foregroundColor(AppTheme.whiteOpacity04)
                
                TextField("搜索地点、用户...", text: $text)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .tint(AppTheme.primaryBlue)
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(AppTheme.inputBackground)
            )
            
            Button(action: { onFilter?() }) {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 15))
                    .foregroundColor(AppTheme.whiteOpacity06)
                    .frame(width: 32, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(AppTheme.inputBackground)
                    )
            }
        }
        .padding(.horizontal, 33)
    }
}

#Preview {
    SearchBar(text: .constant(""))
        .background(AppTheme.darkBgStart)
        .preferredColorScheme(.dark)
}
