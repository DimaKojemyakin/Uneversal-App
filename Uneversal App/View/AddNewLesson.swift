//
//  AddNewLesson.swift
//  Uneversal App
//
//  Created by Дима Кожемякин on 21.12.2023.
//

import SwiftUI

struct AddNewLesson: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager
    
    @State private var isShowAlertIsEmpty = false
    @State private var nameLesson = ""
    @State private var nameTeacher = ""
    @State private var classRoom = ""
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Picker(selection: .constant(1), label: Text(NSLocalizedString("Day of week", comment: ""))) {
                        Text(NSLocalizedString("Monday", comment: "")).tag(1)
                        Text(NSLocalizedString("Tuesday", comment: "")).tag(2)
                        Text(NSLocalizedString("Wednesday", comment: "")).tag(3)
                        Text(NSLocalizedString("Thursday", comment: "")).tag(4)
                        Text(NSLocalizedString("Friday", comment: "")).tag(5)
                        Text(NSLocalizedString("Saturday", comment: "")).tag(6)
                        Text(NSLocalizedString("Sunday", comment: "")).tag(7)
                    }.pickerStyle(WheelPickerStyle())
                    
                    TextField(NSLocalizedString("Lesson name", comment: ""), text: $nameLesson)
                    TextField(NSLocalizedString("Teacher name", comment: ""), text: $nameTeacher)
                    TextField(NSLocalizedString("Number class", comment: ""), text: $classRoom)
                    
                    
                }
                
            }
            .navigationBarItems(trailing:
                HStack {
                    Button(NSLocalizedString("Done", comment: ""), action: {
                        addLesson(nameLesson: nameLesson, nameTeacher: nameTeacher, indexLesson: (userManager.user.lessonsM.count + 1), classRoom: classRoom)
                    })
                    .fontWeight(.bold)
                    .alert(isPresented: $isShowAlertIsEmpty) {
                        Alert(title: Text(NSLocalizedString("Error", comment: "")), message: Text(NSLocalizedString("Your data is not filled in", comment: "")))
                    }
                }
            )
            .navigationTitle(NSLocalizedString("Add new lesson", comment: ""))

        }
    }
    private func addLesson(nameLesson: String, nameTeacher: String, indexLesson: Int, classRoom: String) {
        guard
            !nameLesson.isEmpty,
            !nameTeacher.isEmpty,
            indexLesson > 0,
            !classRoom.isEmpty
        else {
            isShowAlertIsEmpty.toggle()
            return
        }

        let newLesson = lessons(nameTeacher: nameTeacher, nameLesson: nameLesson, classRoom: classRoom)
        let newLessonWithIndex = LessonWithIndex(index: indexLesson, lesson: newLesson)
        userManager.user.lessonsM.append(newLessonWithIndex)
    }

}

#Preview {
    AddNewLesson().environmentObject(DataManager())
        .environmentObject(DataSettings())
        .environmentObject(UserManager())
}
