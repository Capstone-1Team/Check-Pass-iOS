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
    @State private var showPasswordInputView: Bool = false
    @FocusState private var isFocused: Bool?
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading) {
                Text("이메일")
                    .bold()
                    .font(.title)
                
                TextField("이메일을 입력하세요.", text: $emailInput)
                    .font(.title2)
                    .focused($isFocused, equals: true)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                EmailInputStateView(emailInputState: $authViewModel.emailInputState)
                
                Spacer()
                
                ProgressBarView(page: 1.0)
                
                Button(action: {
                    showPasswordInputView = true
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
            .navigationDestination(isPresented: $showPasswordInputView, destination: {
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
        }
    }
}

struct EmailInputView_Previews: PreviewProvider {
    static var previews: some View {
        EmailInputView()
            .environmentObject(AuthViewModel())
    }
}
