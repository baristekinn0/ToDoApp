//
//  ContentView.swift
//  ToDoApp
//
//  Created by Barış Tekin on 18.05.2025.
//

import SwiftUI

struct TaskListView: View {
    // ViewModel'imizi View içinde kullanılabilir hale getiriyoruz.
    // @StateObject, ViewModel'in yaşam döngüsünü bu View'a bağlar.
    // View yeniden çizildiğinde ViewModel kaybolmaz.
    @StateObject var taskListVM = TaskListViewModel()

    // Yeni görev ekleme modal'ını göstermek için state
    @State private var showingAddTaskView = false

    var body: some View {
        NavigationStack { // iOS 16+ için, eski sürümler için NavigationView
            List {
                // ViewModel'deki tasks dizisindeki her bir görev için bir TaskRowView oluştur.
                // tasks dizisindeki elemanlar Identifiable olduğu için doğrudan kullanabiliriz.
                // $taskListVM.tasks içindeki her bir task'a binding ($) ile erişmeliyiz
                // çünkü TaskRowView @Binding var task bekliyor.
                ForEach($taskListVM.tasks) { $task_in_loop in // $task_in_loop, taskListVM.tasks içindeki her bir Task objesine bir binding olur.
                    TaskRowView(task: $task_in_loop)
                }
                .onDelete(perform: deleteTask) // Kaydırarak silme özelliği
            }
            .navigationTitle("Görevlerim")
            .toolbar {
                // Sağ üst köşeye "Ekle" butonu
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddTaskView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                // Sol üst köşeye "Edit" butonu (silme ve sıralama için)
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            // Yeni görev ekleme View'ını modal olarak sun
            .sheet(isPresented: $showingAddTaskView) {
                // AddTaskView'ı buraya ekleyeceğiz (bir sonraki adımda oluşturacağız)
                // Şimdilik geçici bir Text koyabiliriz:
                // Text("Yeni Görev Ekleme Ekranı Buraya Gelecek")
                // AddTaskView(taskListVM: taskListVM) // Gerçek AddTaskView
                NewTaskView(taskListVM: taskListVM) // Bir sonraki adımda oluşturacağımız View
                
            }
            // Eğer hiç görev yoksa bir mesaj göster (isteğe bağlı)
            .overlay {
                if taskListVM.tasks.isEmpty {
                    ContentUnavailableView(
                        "Henüz Görev Yok",
                        systemImage: "checklist.unchecked",
                        description: Text("Yeni görevler eklemek için '+' butonuna dokunun.")
                    )
                }
            }
        }
    }

    // Listeden kaydırarak silme işlemini ViewModel'e ileten fonksiyon
    private func deleteTask(at offsets: IndexSet) {
        taskListVM.deleteTask(at: offsets)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
