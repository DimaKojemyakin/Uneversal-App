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
    var nameTeacher: String
    var nameLesson: String
    var classRoom: String
}

struct LessonWithIndex: Codable, Hashable {
    var index: Int
    var lesson: lessons
}

struct User: Codable {
    var userName = ""
    var userPassword = ""
    var isRegistred = false
    
    var lessonsM: [LessonWithIndex] = [
        
    ]
}
