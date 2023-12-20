import Foundation

class UserManager: ObservableObject {
    @Published var user = User()
    
    func updateUser(userName: String, userPassword: String, isRegistered: Bool, lessonM: [lessons]) {
        DispatchQueue.main.async {
            self.user.userName = userName
            self.user.userPassword = userPassword
            self.user.isRegistred = isRegistered
            self.user.lessonsM = lessonM.enumerated().map { index, lesson in
                return LessonWithIndex(index: index, lesson: lesson)
            }
        }
    }
}

struct lessons: Codable, Hashable {
    let nameTeacher: String
    let nameLesson: String
    let classRoom: String
}

struct LessonWithIndex: Codable, Hashable {
    let index: Int
    let lesson: lessons
}

struct User: Codable {
    var userName = ""
    var userPassword = ""
    var isRegistred = false
    
    var lessonsM: [LessonWithIndex] = [
        LessonWithIndex(index: 0, lesson: lessons(nameTeacher: "Екатерина Дмитриевна", nameLesson: "Разговоры о важном", classRoom: "120")),
        LessonWithIndex(index: 1, lesson: lessons(nameTeacher: "Владимир Юрьевичь", nameLesson: "Технология", classRoom: "120")),
        LessonWithIndex(index: 2, lesson: lessons(nameTeacher: "Владимир Юрьевичь", nameLesson: "Технология", classRoom: "120")),
        LessonWithIndex(index: 3, lesson: lessons(nameTeacher: "Владимир Юрьевичь", nameLesson: "Технология", classRoom: "120")),
        LessonWithIndex(index: 4, lesson: lessons(nameTeacher: "Владимир Юрьевичь", nameLesson: "Технология", classRoom: "120")),
        LessonWithIndex(index: 5, lesson: lessons(nameTeacher: "Владимир Юрьевичь", nameLesson: "Технология", classRoom: "120")),
    ]
}
