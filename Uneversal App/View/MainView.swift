import SwiftUI

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var dataManager: DataManager
    
    @State private var isActiveSheetSettings = false
    @State private var isChangeLessons = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text(NSLocalizedString("Monday",  comment: ""))) {
                        ForEach(userManager.user.lessonsM, id: \.self.index) { lesson in
                            HStack {
                                Text("\(lesson.index + 1).")
                                    .fontWeight(.bold)
                                Text(lesson.lesson.nameLesson).fontWeight(.bold)
                                Spacer()
                                VStack {
                                    Text(lesson.lesson.nameTeacher)
                                        .font(.caption2)
                                    Text(lesson.lesson.classRoom).fontWeight(.light)
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isActiveSheetSettings) {
                Settings()
            }
            .sheet(isPresented: $isChangeLessons){
                ChangeLesson()
            }
            .navigationBarItems(leading: HStack {
                Button(action: { isActiveSheetSettings.toggle() }) {
                    Image(systemName: "gearshape")
                }
            }, trailing:
                                    HStack{
                Button(action: { isChangeLessons.toggle() }){
                    Image(systemName: "plus.app")
                }
            }
            )
            .navigationTitle(NSLocalizedString("Lessons", comment: ""))
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserManager()).environmentObject(DataManager()).environmentObject(DataSettings())
    }
}

