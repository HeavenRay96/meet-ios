import SwiftUI

// MARK: - 忘记密码 - 步骤1：验证身份
struct ForgotPasswordStep1View: View {
    @Environment(\.dismiss) private var dismiss
    @State private var phoneNumber = ""
    @State private var smsCode = ""
    @FocusState private var phoneFocused: Bool
    @FocusState private var smsFocused: Bool
    @State private var navigateToStep2 = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var isVerifyEnabled: Bool {
        phoneNumber.count >= 11 && smsCode.count >= 4
    }
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    
                    // 钥匙图标 - 使用SVG资产
                    Image("icon-key")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 64, height: 64)
                        )
                        .padding(.bottom, 20)
                    
                    // 标题
                    Text("忘记密码")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    // 说明文字
                    Text("验证身份，重置登录密码")
                        .font(.system(size: 17))
                        .foregroundColor(AppTheme.whiteOpacity08)
                        .padding(.bottom, 40)
                    
                    // 手机号输入框
                    PhoneInputField(phoneNumber: $phoneNumber, isFocused: $phoneFocused)
                        .padding(.horizontal, 33)
                        .padding(.bottom, 16)
                    
                    // 验证码输入框
                    SMSInputField(smsCode: $smsCode, isFocused: $smsFocused, phoneNumber: phoneNumber)
                        .padding(.horizontal, 33)
                        .padding(.bottom, 24)
                    
                    // 验证按钮
                    PrimaryButton(
                        title: "验证",
                        isEnabled: isVerifyEnabled,
                        action: { navigateToStep2 = true }
                    )
                    .padding(.horizontal, 33)
                    
                    // 返回登录
                    Button(action: { dismiss() }) {
                        Text("返回登录")
                            .font(.system(size: 15))
                            .foregroundColor(AppTheme.whiteOpacity07)
                            .padding(.top, 24)
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image("icon-chevron-left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppTheme.whiteOpacity08)
                        Text("返回")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(AppTheme.whiteOpacity08)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("忘记密码")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .navigationDestination(isPresented: $navigateToStep2) {
            ForgotPasswordStep2View()
        }
        .alert("提示", isPresented: $showAlert) {
            Button("确定", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}

// MARK: - 忘记密码 - 步骤2：设置新密码
struct ForgotPasswordStep2View: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @FocusState private var newPwdFocused: Bool
    @FocusState private var confirmPwdFocused: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var isResetEnabled: Bool {
        newPassword.count >= 6 && confirmPassword == newPassword && !newPassword.isEmpty
    }
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    
                    // 钥匙图标 - 使用SVG资产
                    Image("icon-key")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 64, height: 64)
                        )
                        .padding(.bottom, 20)
                    
                    // 标题
                    Text("设置新密码")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    // 说明文字
                    Text("请输入您的新登录密码")
                        .font(.system(size: 17))
                        .foregroundColor(AppTheme.whiteOpacity08)
                        .padding(.bottom, 40)
                    
                    // 新密码输入框
                    PasswordInputField(password: $newPassword, isFocused: $newPwdFocused, placeholder: "请输入新密码")
                        .padding(.horizontal, 33)
                        .padding(.bottom, 16)
                    
                    // 确认新密码输入框
                    PasswordInputField(password: $confirmPassword, isFocused: $confirmPwdFocused, placeholder: "确认新密码")
                        .padding(.horizontal, 33)
                        .padding(.bottom, 24)
                    
                    // 重置密码按钮
                    PrimaryButton(
                        title: "重置密码",
                        isEnabled: isResetEnabled,
                        action: {
                            alertMessage = "密码重置成功，请返回登录"
                            showAlert = true
                        }
                    )
                    .padding(.horizontal, 33)
                    
                    // 返回登录
                    Button(action: { dismiss() }) {
                        Text("返回登录")
                            .font(.system(size: 15))
                            .foregroundColor(AppTheme.whiteOpacity07)
                            .padding(.top, 24)
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image("icon-chevron-left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppTheme.whiteOpacity08)
                        Text("返回")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(AppTheme.whiteOpacity08)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("设置新密码")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .alert("提示", isPresented: $showAlert) {
            Button("确定", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordStep1View()
    }
}
