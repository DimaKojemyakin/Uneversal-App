// UserManager.swift
import Foundation

class UserManager: ObservableObject {
    @Published var user = User()

    func updateUser(userName: String, userPassword: String, isRegistered: Bool) {
        DispatchQueue.main.async {
            self.user.userName = userName
            self.user.userPassword = userPassword
            self.user.isRegistred = isRegistered
        }
    }
}

struct User: Codable {
    var userName = ""
    var userPassword = ""
    var isRegistred = false
}
