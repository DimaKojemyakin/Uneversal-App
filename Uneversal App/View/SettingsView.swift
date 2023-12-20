//
//  Settings.swift
//  Universal application
//
//  Created by Дима Кожемякин on 13.12.2023.
//

import SwiftUI
import AlertKit

struct Settings: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager
    @State private var isActiveAlert = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Develop")) {
                        Toggle("Development Mode", isOn: $dataSettings.settingsUser.developMod)
                    }
                    Section() {
                        Button(action: {
                            isActiveAlert.toggle()
                        }) {
                            Text("Log out").foregroundColor(.red)
                        }
                        .alert("Do you really want to get out?", isPresented: $isActiveAlert) {
                            Button("Ok", role: .destructive) {
                                settings() // Вызываем метод settings() при нажатии кнопки "Ok"
                                AlertKitAPI.present(
                                    title: "Log out",
                                    icon: .done,
                                    style: .iOS16AppleMusic,
                                    haptic: .success
                                )
                                
                            }
                            
                            Button("Cancel", role: .cancel) { }
                        }
                       
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func settings() {
        userManager.user.isRegistred = false
        dataManager.deleteData(key: "user")
        userManager.user.userName = ""
        userManager.user.userPassword = ""
    }
}

#Preview {
    Settings().environmentObject(UserManager()).environmentObject(DataManager()).environmentObject(DataSettings())
}
