//
//  StartView.swift
//  Universal application
//
//  Created by Дима Кожемякин on 13.12.2023.
//

import SwiftUI
import LocalAuthentication

struct StartView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        FaceIDView()
            .navigationBarHidden(true)
    }
}

struct FaceIDView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager

    @State private var authenticationSuccess = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .pink.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                if authenticationSuccess {
                    if userManager.user.isRegistred == true {
                        MainView()
                    } else {
                        RegisterView()
                    }
                } else {
                    Button(action: { authenticate() }) {
                        Image(systemName: "faceid")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    DispatchQueue.main.async {
                        authenticationSuccess = true
                    }
                } else {
                    print("Authentication failed")
                }
            }
        } else {
            print("Biometric authentication not available")
        }
    }
    
}



#Preview {
    StartView().environmentObject(UserManager()).environmentObject(DataManager())
}
