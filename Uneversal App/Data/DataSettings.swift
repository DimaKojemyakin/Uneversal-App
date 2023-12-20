//
//  DataSettings.swift
//  Universal application
//
//  Created by Дима Кожемякин on 13.12.2023.
//

import Foundation

class DataSettings: ObservableObject {
    @Published var settingsUser = SettingsUser()
    
    
}

struct SettingsUser {
    var developMod = false
    var logOut = false
}
