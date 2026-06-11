import SwiftUI

// MARK: - 登录页（v4.0 分步交互）
struct LoginView: View {
    @State private var phoneNumber = ""
    @State private var smsCode = ""
    @State private var password = ""
    @State private var isPasswordMode = false
    @State private var isAgreed = false
    @State private var currentStep = 1  // 1=手机号输入, 2=验证码输入
    @State private var countdown = 0
    @State private var timer: Timer?
    @FocusState private var phoneFocused: Bool
    @FocusState private var passwordFocused: Bool
    @State private var showForgotPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 步骤1：获取验证码按钮是否可用
    private var isGetCodeEnabled: Bool {
        phoneNumber.count >= 11
    }
    
    // 步骤2：验证并登录按钮是否可用
    private var isLoginEnabled: Bool {
        guard isAgreed else { return false }
        return smsCode.count == 6
    }
    
    // 密码模式：登录按钮是否可用
    private var isPasswordLoginEnabled: Bool {
        guard isAgreed else { return false }
        guard phoneNumber.count >= 11 else { return false }
        return password.count >= 6
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundGradient()
                
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 80)
                        
                        if isPasswordMode {
                            passwordModeContent
                        } else if currentStep == 1 {
                            step1Content
                        } else {
                            step2Content
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationDestination(isPresented: $showForgotPassword) {
                ForgotPasswordStep1View()
            }
            .alert("提示", isPresented: $showAlert) {
                Button("确定", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // MARK: - 步骤1：手机号输入
    private var step1Content: some View {
        VStack(spacing: 0) {
            // 品牌区域（大尺寸）
            BrandLogo(size: 80)
                .padding(.bottom, 24)
            
            BrandSlogan(fontSize: 34)
                .padding(.bottom, 32)
            
            // 手机号输入框
            PhoneInputField(phoneNumber: $phoneNumber, isFocused: $phoneFocused)
                .padding(.horizontal, 33)
                .padding(.bottom, 16)
            
            // 切换链接
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isPasswordMode = true
                }
            }) {
                Text("使用密码登录")
                    .font(.system(size: 15))
                    .foregroundColor(AppTheme.whiteOpacity08)
            }
            .padding(.bottom, 24)
            
            // 获取验证码按钮
            PrimaryButton(
                title: countdown > 0 ? "\(countdown)s" : "获取验证码",
                isEnabled: isGetCodeEnabled && countdown == 0,
                action: sendCode
            )
            .padding(.horizontal, 33)
            .padding(.bottom, 16)
            
            // 协议勾选框
            AgreementCheckbox(isChecked: $isAgreed)
        }
    }
    
    // MARK: - 步骤2：验证码输入
    private var step2Content: some View {
        VStack(spacing: 0) {
            // 品牌区域（缩小）
            BrandLogo(size: 48)
                .padding(.bottom, 16)
            
            BrandSlogan(fontSize: 28)
                .padding(.bottom, 24)
            
            // 自动注册提示
            Text("未注册的手机号登录成功后将自动注册")
                .font(.system(size: 13))
                .foregroundColor(AppTheme.whiteOpacity06)
                .padding(.bottom, 24)
            
            // 6位独立验证码输入框
            CodeInputField(code: $smsCode)
                .padding(.horizontal, 33)
                .padding(.bottom, 24)
            
            // 切换链接
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isPasswordMode = true
                }
            }) {
                Text("使用密码登录")
                    .font(.system(size: 15))
                    .foregroundColor(AppTheme.whiteOpacity08)
            }
            .padding(.bottom, 24)
            
            // 验证并登录按钮
            PrimaryButton(
                title: "验证并登录",
                isEnabled: isLoginEnabled,
                action: loginAction
            )
            .padding(.horizontal, 33)
            .padding(.bottom, 16)
            
            // 协议勾选框
            AgreementCheckbox(isChecked: $isAgreed)
            
            // 返回步骤1
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    smsCode = ""
                    currentStep = 1
                }
            }) {
                Text("重新输入手机号")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.whiteOpacity06)
                    .padding(.top, 16)
            }
        }
    }
    
    // MARK: - 密码模式
    private var passwordModeContent: some View {
        VStack(spacing: 0) {
            BrandLogo(size: 80)
                .padding(.bottom, 24)
            
            BrandSlogan(fontSize: 34)
                .padding(.bottom, 32)
            
            // 手机号输入框
            PhoneInputField(phoneNumber: $phoneNumber, isFocused: $phoneFocused)
                .padding(.horizontal, 33)
                .padding(.bottom, 16)
            
            // 密码输入框
            PasswordInputField(password: $password, isFocused: $passwordFocused)
                .padding(.horizontal, 33)
                .padding(.bottom, 16)
            
            // 切换链接
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isPasswordMode = false
                }
            }) {
                Text("使用验证码登录")
                    .font(.system(size: 15))
                    .foregroundColor(AppTheme.whiteOpacity08)
            }
            .padding(.bottom, 12)
            
            // 忘记密码
            Button(action: { showForgotPassword = true }) {
                Text("忘记密码？")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(AppTheme.whiteOpacity08)
            }
            .padding(.bottom, 24)
            
            // 验证并登录按钮
            PrimaryButton(
                title: "验证并登录",
                isEnabled: isPasswordLoginEnabled,
                action: loginAction
            )
            .padding(.horizontal, 33)
            .padding(.bottom, 16)
            
            // 协议勾选框
            AgreementCheckbox(isChecked: $isAgreed)
        }
    }
    
    // MARK: - 操作
    private func sendCode() {
        countdown = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
        
        // 切换到步骤2
        withAnimation(.easeInOut(duration: 0.25)) {
            currentStep = 2
        }
    }
    
    private func loginAction() {
        if isPasswordMode {
            alertMessage = "密码登录功能（演示）"
        } else {
            alertMessage = "验证码登录成功（演示）"
        }
        showAlert = true
    }
}

#Preview {
    LoginView()
}
