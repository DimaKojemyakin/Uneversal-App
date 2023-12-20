//
//  LoveIS.swift
//  Uneversal App
//
//  Created by Дима Кожемякин on 16.12.2023.
//

import SwiftUI

struct LoveIS: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager
    
    @State private var isActiveSheetSettings = false
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Text("No image selected")
                        }
                    }
                }
            }
            .navigationTitle("Main view")
            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        // Открываем камеру для выбора фотографии
                        isImagePickerPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            )
            
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
            .navigationBarBackButtonHidden(false)
        }
        
    }
}

#Preview {
    LoveIS()
}
