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
    @FocusState private var isFocused: Bool?
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading) {                
//                PageStepVIew(step: 1)
//                    .padding(.bottom)
                
                Text("이메일")
                    .bold()
                    .font(.title2)
                
                HStack {
                    Image(systemName: "envelope")
                    
                    TextField("이메일을 입력하세요.", text: $emailInput)
                        .font(.title3)
                        .focused($isFocused, equals: true)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                EmailInputStateView(emailInputState: $authViewModel.emailInputState)
                
                Spacer()
                
                Button(action: {
                    authViewModel.showPasswordInputView = true
                }, label: {
                    Text("다음")
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
                .disabled(authViewModel.emailInputState != .isValid)
            }
            .padding()
            .navigationDestination(isPresented: $authViewModel.showPasswordInputView, destination: {
                PasswordInputView(emailInput: $emailInput)
                    .environmentObject(authViewModel)
            })
            .onAppear {
                isFocused = true
            }
            .onDisappear {
                authViewModel.emailInputState = .isBlank
            }
            .onChange(of: emailInput, perform: {
                authViewModel.checkEmailInput($0)
            })
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EmailInputView_Previews: PreviewProvider {
    static var previews: some View {
        EmailInputView()
            .environmentObject(AuthViewModel())
    }
}
