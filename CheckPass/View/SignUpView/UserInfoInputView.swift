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
    @State private var idInput: String = ""
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
                    Group {
                        HStack {
                            Text("구분")
                                .bold()
                                .font(.title)

                            Spacer()
                        }

                        Picker("구분을 선택 해주세요.", selection: $selectedUserType) {
                            ForEach(UserType.userTypeList, id:\.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    .padding([.leading, .trailing])
                    
                    Group {
                        HStack {
                            Text("이름")
                                .bold()
                                .font(.title)
                            
                            Spacer()
                        }
                        
                        TextField("이름을 입력하세요.", text: $nameInput)
                            .font(.title2)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    .padding([.leading, .trailing])
                    
                    Group {
                        HStack {
                            Text("번호")
                                .bold()
                                .font(.title)
                            
                            Spacer()
                        }
                        
                        TextField("학번 또는 교직원 번호를 입력하세요.", text: $idInput)
                            .font(.title2)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                    .padding([.leading, .trailing])
                }
                
                ProgressBarView(page: 3.0)
                    .padding([.leading, .trailing])
                
                Button(action: {}, label: {
                    Text("완료")
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
                .disabled(nameInput.isEmpty || idInput.isEmpty)
                .padding([.leading, .trailing, .bottom])
            }
        }
    }
}

struct UserInfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoInputView(emailInput: .constant(""), passwordInput: .constant(""))
            .environmentObject(AuthViewModel())
    }
}
