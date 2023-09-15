//
//  SignInView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var showMainView: Bool = false
    @State private var showBlankFieldAlert: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: UIScreen.main.bounds.height * 0.3)
                    .offset(x: -(UIScreen.main.bounds.width * 0.4), y: -(UIScreen.main.bounds.height * 0.5))
                    .shadow(radius: 20)
                
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: UIScreen.main.bounds.height * 0.46)
                    .offset(x: UIScreen.main.bounds.width * 0.6, y: UIScreen.main.bounds.height * 0.5)
                    .shadow(radius: 20)
                
                VStack {
                    if colorScheme == .light {
                        Image("logo_color")
                            .resizable()
                            .frame(width: 1024 * 0.2, height: 256 * 0.2)
                            .padding([.bottom], UIScreen.main.bounds.height * 0.05)
                            .padding(.top, UIScreen.main.bounds.height * 0.15)
                    } else {
                        Image("logo_white")
                            .resizable()
                            .frame(width: 1024 * 0.2, height: 256 * 0.2)
                            .padding([.bottom], UIScreen.main.bounds.height * 0.05)
                            .padding(.top, UIScreen.main.bounds.height * 0.15)
                    }
                    
                    TextField("이메일을 입력하세요.", text: $emailInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    
                    SecureField("비밀번호를 입력하세요.", text: $passwordInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    Button(action: {
                        authViewModel.signIn(email: emailInput, pw: passwordInput)
                    }, label: {
                        if authViewModel.isSignInProgress == true {
                            ProgressView()
                                .padding(.all, 15)
                                .frame(maxWidth: .infinity)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        } else {
                            Text("로그인")
                                .padding(.all, 15)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                    })
                    .padding([.top, .bottom])
                    .navigationDestination(isPresented: $authViewModel.showMainView) {
                        MainTabView()
                            .environmentObject(authViewModel)
                    }
                    
                    Divider()
                        .padding(.bottom)
                    
                    
                    HStack {
                        NavigationLink(destination: {
                            EmailInputView()
                                .environmentObject(authViewModel)
                        }, label: {
                            Text("새 계정 만들기")
                                .foregroundColor(.gray)
                        })
                        
                        Divider()
                            .frame(height: 30)
                        
                        NavigationLink(destination: {}, label: {
                            Text("비밀번호 찾기")
                                .foregroundColor(.gray)
                        })
                    }
                    
                    Spacer()
                }
                .alert(isPresented: $authViewModel.showSignInAlert) {
                    if authViewModel.alertType == .isBlank {
                        return Alert(title: Text("알림"), message: Text("이메일과 비밀번호를 입력하세요."))
                    } else {
                        return Alert(title: Text("로그인 실패"), message: Text("존재하지 않는 아이디 이거나 비밀번호가 일치하지 않습니다."))
                    }
                }
                .onAppear {
                    if Auth.auth().currentUser != nil {
                        authViewModel.showMainView = true
                    }
                }
                .padding()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
