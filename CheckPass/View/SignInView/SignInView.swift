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
                Image("background_image")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    Text("CHECKPASS")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, UIScreen.main.bounds.width * 0.2)
                        .padding(.top, UIScreen.main.bounds.width * 0.3)
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .opacity(0.6)
                        .overlay(
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.black)
                                
                                TextField("",
                                          text: $emailInput,
                                          prompt: Text("이메일을 입력하세요").foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255)))
                            }
                                .padding()
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 1)
                        )
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                        .opacity(0.6)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .overlay(
                            HStack {
                                Image("custom_lock")
                                    .resizable()
                                    .frame(width: 19)
                                    .offset(x: 3)
                                    .padding(.trailing, 4)
                                
                                SecureField("",
                                            text: $passwordInput,
                                            prompt: Text("비밀번호를 입력하세요").foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255)))
                            }
                                .padding()
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 1)
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
                                .cornerRadius(20)
                        } else {
                            Text("로그인")
                                .padding(.all, 15)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(.black)
                                .cornerRadius(30)
                        }
                    })
                    .padding([.top, .bottom])
                    .navigationDestination(isPresented: $authViewModel.showMainView) {
                        MainTabView()
                            .environmentObject(authViewModel)
                    }
                    
                    
                    HStack {
                        Button(action: {
                            authViewModel.showEmailInputView = true
                        }, label: {
                            Text("새 계정 만들기")
                                .foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255))
                        })
                        .padding(.trailing)
                        
                        Rectangle()
                            .fill(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255))
                            .frame(width: 1, height: 30)
                        
                        NavigationLink(destination: {}, label: {
                            Text("비밀번호 찾기")
                                .foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255))
                        })
                        .padding(.leading)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .navigationDestination(isPresented: $authViewModel.showEmailInputView, destination: {
                    EmailInputView()
                        .environmentObject(authViewModel)
                })
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
