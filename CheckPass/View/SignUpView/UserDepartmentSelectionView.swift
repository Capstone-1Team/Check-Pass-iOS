//
//  UserDepartmentSelectionView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/19.
//

import SwiftUI

let colleges: [String] = ["단과대를 선택하세요", "융합기술대학", "공과대학", "인문사회대학", "보건생명대학", "철도대학", "미래융합대학", "교양학부", "자유전공학부", "창의융합학부"]
let departments: [String: [String]] = ["단과대를 선택하세요": ["학과를 선택하세요"], "융합기술대학": ["학과를 선택하세요", "기계공학과", "자동차공학과", "항공·기계설계학과", "전기공학과", "전자공학과", "컴퓨터공학과", "컴퓨터소프트웨어학과", "AI로봇공학과", "바이오메디컬융합학과", "정밀의료·의료기기학과"]]

struct UserDepartmentSelectionView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedCollege: String = "단과대를 선택하세요"
    @State private var selectedDepartment: String = "학과를 선택하세요"
    @Binding var emailInput: String
    @Binding var passwordInput: String
    @Binding var nameInput: String
    @Binding var userNumInput: String
    @Binding var selectedUserType: String
    
    var body: some View {
        ZStack {
            if colorScheme == . dark {
                Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("거의 다 끝났어요!")
                    .bold()
                    .font(.title)
                    .padding(.bottom, -10)
                
                Text("곧 CHECKPASS를 사용할 수 있어요")
                    .bold()
                    .font(.title2)
                
                Spacer()
                
                Image("departmentSelectionImage_light")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.width * 0.8)
                
                Spacer()
                
                HStack {
                    Image(systemName: "building.columns.fill")
                        .padding(.trailing, -10)
                    
                    Picker("단과대", selection: $selectedCollege) {
                        ForEach(colleges, id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                HStack {
                    Image(systemName: "graduationcap")
                        .padding(.trailing, -10)
                    
                    Picker("학과", selection: $selectedDepartment) {
                        ForEach(departments[selectedCollege] ?? ["선택"], id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: {
                    authViewModel.singUp(emailInput: emailInput, pwInput: passwordInput, nameInput: nameInput, userNumInput: userNumInput, selectedUserType: selectedUserType, selectedDepartment: [selectedCollege, selectedDepartment])
                }, label: {
                    if authViewModel.isSignUpProgress {
                        ProgressView()
                            .padding(.all, 15)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    } else {
                        Text("완료")
                            .padding(.all, 15)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    }
                })
                .disabled(selectedDepartment == "학과를 선택하세요" || selectedCollege == "단과대를 선택하세요")
            }
            .padding()
        }
    }
}

struct UserDepartmentSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserDepartmentSelectionView(emailInput: .constant(""), passwordInput: .constant(""), nameInput: .constant(""), userNumInput: .constant(""), selectedUserType: .constant(""))
            .environmentObject(AuthViewModel())
    }
}
