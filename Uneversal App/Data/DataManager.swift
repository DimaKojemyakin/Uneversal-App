//
//  DataManager.swift
//  Universal application
//
//  Created by Дима Кожемякин on 13.12.2023.
//

import Foundation

class DataManager: ObservableObject {
    
    // Сохранение данных в UserDefaults
    func saveData(user: User, key: String ) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    // Загрузка данных из UserDefaults
    func loadData(key: String) -> User? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                return user
            } catch {
                print("Failed to load data: \(error)")
            }
        }
        return nil
    }
    
    // Удаление данных
    func deleteData(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
