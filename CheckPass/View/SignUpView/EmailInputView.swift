//
//  EmailInputView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/08.
//

import SwiftUI

struct EmailInputView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State private var emailInput: String = ""
    @State private var isKeyboardVisible = false
    @State private var showInvaildEmailAlert: Bool = false
    @State private var showExistingEmailAlert: Bool = false
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                    .ignoresSafeArea()
            }

            Image("signupimage")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.width * 0.8)
                .offset(y: -120)
            
            VStack(alignment: .leading, spacing: 16) {
                
                if !isKeyboardVisible {
                    Text("출석 체크를 간편하게!")
                        .bold()
                        .font(.title)
                    
                    Text("어디서든 쉽게 이용하세요")
                        .bold()
                        .font(.title2)
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "envelope")
                    
                    TextField("이메일을 입력하세요.", text: $emailInput)
                        .font(.title3)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                Text("회원가입 시 체크패스 서비스 이용 약관과 개인정보 보호 정책에 동의하게 됩니다.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .alert(isPresented: $showExistingEmailAlert, content: {
                        Alert(title: Text("이미 존재하는 이메일입니다."))
                    })
                
                Button(action: {
                    if authViewModel.emailInputState == .isExist {
                        showExistingEmailAlert = true
                    } else if authViewModel.emailInputState == .isIncorrectForm {
                        showInvaildEmailAlert = true
                    } else {
                        authViewModel.showPasswordInputView = true
                    }
                }, label: {
                    Text("다음")
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                .disabled(authViewModel.emailInputState == .isBlank)
                .alert(isPresented: $showInvaildEmailAlert, content: {
                    Alert(title: Text("이메일 형식이 맞지 않습니다."))
                })
            }
            .padding()
            .navigationDestination(isPresented: $authViewModel.showPasswordInputView, destination: {
                PasswordInputView(emailInput: $emailInput)
                    .environmentObject(authViewModel)
            })
            .onDisappear {
                authViewModel.emailInputState = .isBlank
            }
            .onChange(of: emailInput, perform: {
                authViewModel.checkEmailInput($0)
            })
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                withAnimation(.easeInOut) {
                    self.isKeyboardVisible = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                withAnimation(.easeInOut) {
                    self.isKeyboardVisible = false
                }
            }
        }
    }
}

struct EmailInputView_Previews: PreviewProvider {
    static var previews: some View {
        EmailInputView()
            .environmentObject(AuthViewModel())
    }
}
