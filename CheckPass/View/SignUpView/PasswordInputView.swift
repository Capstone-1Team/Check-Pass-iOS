//
//  PasswordInputView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/10.
//

import SwiftUI

struct PasswordInputView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State private var passwordInput: String = ""
    @State private var passwordCheckInput: String = ""
    @Binding var emailInput: String
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading) {
//                PageStepVIew(step: 2)
//                    .padding(.bottom)
                
                Text("비밀번호")
                    .bold()
                    .font(.title2)
                
                PasswordFieldView(textInput: $passwordInput, title: "비밀번호는 6자리 이상 가능합니다.", keyboardFocus: true)
                
                PasswordFieldView(textInput: $passwordCheckInput, title: "비밀번호를 다시 확인합니다.", keyboardFocus: false)
                
                PasswordInputStateView(passwordInput: $passwordInput, passwordInputCheck: $passwordCheckInput)
                
                Spacer()
                
                Button(action: {
                    authViewModel.showUserInfoInputView = true
                }, label: {
                    Text("다음")
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
                .disabled(passwordInput != passwordCheckInput || passwordInput.isEmpty)
            }
            .padding()
            .navigationDestination(isPresented: $authViewModel.showUserInfoInputView, destination: {
                UserInfoInputView(emailInput: $emailInput, passwordInput: $passwordInput)
                    .environmentObject(authViewModel)
            })
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PasswordInputView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputView(emailInput: .constant(""))
            .environmentObject(AuthViewModel())
    }
}
