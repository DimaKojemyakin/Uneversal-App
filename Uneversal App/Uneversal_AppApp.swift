//
//  Uneversal_AppApp.swift
//  Uneversal App
//
//  Created by Дима Кожемякин on 15.12.2023.
//

import SwiftUI

@main
struct Uneversal_AppApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var userManager = UserManager()
    @StateObject var dataSettings = DataSettings()
    @StateObject var dataManager = DataManager()
    
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(userManager)
                .environmentObject(dataManager)
                .environmentObject(dataSettings)
                .onAppear {
                    // Загрузка данных из UserDefaults и установка их в userManager
                    if let loadedUser = dataManager.loadData(key: "user") {
                        userManager.user = loadedUser
                    }
                }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                // Сохранение данных в UserDefaults
                dataManager.saveData(user: userManager.user, key: "user")
            }
        }
    }
}
