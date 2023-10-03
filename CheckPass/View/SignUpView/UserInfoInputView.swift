//
//  UserInfoInputView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/10.
//

import SwiftUI

struct UserInfoInputView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedUserType: String = ""
    @State private var nameInput: String = ""
    @State private var userNumInput: String = ""
    @Binding var emailInput: String
    @Binding var passwordInput: String
    
    var body: some View {
        ZStack {
            if colorScheme == . dark {
                Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                    .ignoresSafeArea()
            }
            
            VStack {
                ScrollView {                        
                    UserTypeSelectionView(selectedUserType: $selectedUserType)
                        .padding([.leading, .trailing, .bottom])
                        
                    UserNameInputView(nameInput: $nameInput)
                        .padding([.leading, .trailing, .bottom])
                    
                    UserNumberInputView(idInput: $userNumInput)
                        .padding([.leading, .trailing])
                }
                
                Button(action: {
                    authViewModel.showUserDepartmentSelectionView = true
                }, label: {
                    if authViewModel.isSignUpProgress {
                        ProgressView()
                            .padding(.all, 15)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    } else {
                        Text("다음")
                            .padding(.all, 15)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    }
                })
                .disabled(nameInput.isEmpty || userNumInput.isEmpty || selectedUserType.isEmpty)
                .padding([.leading, .trailing, .bottom])
            }
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $authViewModel.showUserDepartmentSelectionView, destination: {
            UserDepartmentSelectionView(emailInput: $emailInput, passwordInput: $passwordInput, nameInput: $nameInput, userNumInput: $userNumInput, selectedUserType: $selectedUserType)
                .environmentObject(authViewModel)
        })
    }
}

struct UserInfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoInputView(emailInput: .constant(""), passwordInput: .constant(""))
            .environmentObject(AuthViewModel())
    }
}
