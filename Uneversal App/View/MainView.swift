import SwiftUI

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager
    
    
    @State private var isActiveSheetSettings = false
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            TabView{
                LoveIS()
                    .badge("!")
                    .tabItem { Label("Love is", systemImage: "heart") }
                LoveIS()
                    .badge("!")
                    .tabItem { Label("Calculator", systemImage: "faxmachine") }
            }
            .sheet(isPresented: $isActiveSheetSettings) {
                Settings()
            }
            .navigationBarItems(leading: HStack {
                Button(action: { isActiveSheetSettings.toggle() }) {
                    Image(systemName: "gearshape")
                }
            }
                                
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserManager()).environmentObject(DataManager()).environmentObject(DataSettings())
    }
}
