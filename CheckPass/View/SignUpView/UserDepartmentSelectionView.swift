//
//  UserDepartmentSelectionView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/19.
//

import SwiftUI

let colleges: [String] = ["선택", "융합기술대학", "공과대학", "인문사회대학", "보건생명대학", "철도대학", "미래융합대학", "교양학부", "자유전공학부", "창의융합학부"]
let departments: [String: [String]] = ["선택": ["선택"], "융합기술대학": ["선택", "기계공학과", "자동차공학과", "항공·기계설계학과", "전기공학과", "전자공학과", "컴퓨터공학과", "컴퓨터소프트웨어학과", "AI로봇공학과", "바이오메디컬융합학과", "정밀의료·의료기기학과"]]

struct UserDepartmentSelectionView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var selectedCollege: String = "선택"
    @State private var selectedDepartment: String = "선택"
    @Binding var emailInput: String
    @Binding var passwordInput: String
    @Binding var nameInput: String
    @Binding var userNumInput: String
    @Binding var selectedUserType: String
    
    var body: some View {
        VStack(alignment: .leading) {
//            PageStepVIew(step: 4)
//                .padding(.bottom)
            
            Text("소속")
                .bold()
                .font(.title2)
            
            HStack {
                Image(systemName: "building.columns.fill")
                
                Text("단과대")
                
                Spacer()
                
                Picker("단과대", selection: $selectedCollege) {
                    ForEach(colleges, id:\.self) {
                        Text($0)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
            HStack {
                Image(systemName: "graduationcap")
                
                Text("학과")
                
                Spacer()
                
                Picker("학과", selection: $selectedDepartment) {
                    ForEach(departments[selectedCollege] ?? ["선택"], id:\.self) {
                        Text($0)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            )
            
            Spacer()
            
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
            .disabled(selectedDepartment == "선택" || selectedCollege == "선택")
        }
        .padding()
    }
}

struct UserDepartmentSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserDepartmentSelectionView(emailInput: .constant(""), passwordInput: .constant(""), nameInput: .constant(""), userNumInput: .constant(""), selectedUserType: .constant(""))
            .environmentObject(AuthViewModel())
    }
}
