//
//  RegisterView.swift
//  Universal application
//
//  Created by Дима Кожемякин on 13.12.2023.
//

import SwiftUI
import LocalAuthentication

struct RegisterView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataManager: DataManager
    @State private var isActiveAlert = false
    @State private var isUnlocked = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Text("Login")
                    Spacer()
                }
                TextFields(userName: $userManager.user.userName)
                HStack {
                    Text("Password")
                    Spacer()
                }
                TextFields(userName: $userManager.user.userPassword)
                Button(action: {
                    authenticate()
                }) {
                    Text("Done").foregroundColor(.white)
                }
                .buttonStyle(BorderedButtonStyle())
                .background(Color.blue)
                .cornerRadius(10)
                .alert(isPresented: $isActiveAlert) {
                    Alert(title: Text("Error"), message: Text("Please enter your given"))
                }
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }

    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    DispatchQueue.main.async {
                        isUnlocked = true
                        registerView()
                    }
                } else {
                    // there was a problem
                    print("Authentication failed")
                }
            }
        } else {
            print("Biometric authentication not available")
        }
    }

    private func registerView() {
        if isUnlocked && !userManager.user.userName.isEmpty {
            userManager.user.isRegistred = true
            dataManager.saveData(user: userManager.user, key: "user")
            print(dataManager.loadData(key: "user")!)
        } else {
            isActiveAlert.toggle()
        }
    }
}

struct TextFields: View {
    @Binding var userName: String

    var body: some View {
        VStack {
            TextField("Enter your login", text: $userName).textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    RegisterView().environmentObject(UserManager()).environmentObject(DataManager())
}
