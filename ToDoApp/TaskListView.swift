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
                ForEach($taskListVM.tasks) { $task_in_loop in
                    TaskRowView(task: $task_in_loop)
                        .id(task_in_loop.id) // HER BİR SATIRA KENDİ ID'SİNİ VER
                }
                .onDelete(perform: deleteTask)
            }
            .id(UUID()) // BURAYA EKLEYEREK DENE
            .navigationTitle("Görevlerim")
            // ...
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
