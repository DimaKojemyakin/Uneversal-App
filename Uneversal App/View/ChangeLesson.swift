//
//  ChangeLesson.swift
//  Uneversal App
//
//  Created by Дима Кожемякин on 20.12.2023.
//

import SwiftUI

struct ChangeLesson: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager
    
    @State private var isShowSheetAddNewLesson = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(NSLocalizedString("Monday",  comment: ""))) {
                    ForEach(userManager.user.lessonsM.indices, id: \.self) { index in
                        let lesson = userManager.user.lessonsM[index]
                        
                        HStack {
                            Text("\(index + 1).")
                                .fontWeight(.bold)
                            TextField(NSLocalizedString("Lesson name",  comment: ""), text: $userManager.user.lessonsM[index].lesson.nameLesson)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                TextField(NSLocalizedString("Teacher name",  comment: ""), text: $userManager.user.lessonsM[index].lesson.nameTeacher)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 8)
                                    .font(.caption2)
                                TextField(NSLocalizedString("Number class",  comment: ""), text: $userManager.user.lessonsM[index].lesson.classRoom)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 8)
                                    .fontWeight(.light)
                                
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowSheetAddNewLesson ) {
                AddNewLesson()
            }
            .navigationBarItems(leading:
                                    HStack {
                Button( action: { isShowSheetAddNewLesson.toggle() } ){
                    Image(systemName: "plus.square.fill.on.square.fill")
                }
            }
            )
            .navigationTitle(NSLocalizedString("Change lessons",  comment: ""))
        }
    }
    
    
}

struct ChangeLesson_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangeLesson()
                .environmentObject(DataManager())
                .environmentObject(DataSettings())
                .environmentObject(UserManager())
        }
    }
}
