//
//  SignInView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    @State private var inputEmail: String = ""
    @State private var inputPassword: String = ""
    @State private var showMainView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("CheckPass")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding([.top, .bottom], UIScreen.main.bounds.height * 0.13)
                
                TextField("이메일을 입력하세요.", text: $inputEmail)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                
                SecureField("비밀번호를 입력하세요.", text: $inputPassword)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                Button(action: {
                    authViewModel.signIn(email: inputEmail, pw: inputPassword)
                }, label: {
                    Text("로그인")
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
                .padding([.top, .bottom])
                .navigationDestination(isPresented: $authViewModel.showMainView) {
                    MainView()
                }
                
                Divider()
                    .padding(.bottom)
                
                Button(action:{}, label: {
                    Text("회원가입")
                        .foregroundColor(.gray)
                })
                .alert(isPresented: $authViewModel.showSignInAlert) {
                    Alert(title: Text("로그인 실패"), message: Text("존재하지 않는 아이디 이거나 비밀번호가 일치하지 않습니다."))
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
