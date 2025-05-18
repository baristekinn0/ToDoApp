//
//  NewTaskView.swift
//  ToDoApp
//
//  Created by Barış Tekin on 18.05.2025.
//

import SwiftUI

struct NewTaskView: View {
    // Bu View'ı kapatmak için (modal'ı dismiss etmek için) Environment değeri
    @Environment(\.dismiss) var dismiss

    // TaskListViewModel'e erişim. @ObservedObject kullanıyoruz çünkü bu View,
    // ViewModel'in sahibi değil, sadece onu kullanıyor ve değişikliklerini gözlemliyor.
    @ObservedObject var taskListVM: TaskListViewModel

    // Kullanıcının girdiği görev başlığını tutacak state
    @State private var taskTitle: String = ""
    // Kullanıcıya hata mesajı göstermek için (örneğin boş başlık)
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack { // Veya NavigationView
            Form {
                Section(header: Text("Yeni Görev Detayları")) {
                    TextField("Görev başlığını girin...", text: $taskTitle)
                }

                Section {
                    Button("Görevi Ekle") {
                        if taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "Görev başlığı boş olamaz!"
                            showingAlert = true
                        } else {
                            taskListVM.addTask(title: taskTitle)
                            dismiss() // Modal'ı kapat
                        }
                    }
                    // Butonun tüm satırı kaplaması ve mavi olması için (isteğe bağlı)
                    .frame(maxWidth: .infinity, alignment: .center)
                    // .tint(.blue) // iOS 15+ için
                }
            }
            .navigationTitle("Yeni Görev Ekle")
            .navigationBarTitleDisplayMode(.inline) // Başlığı daha küçük göster
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss() // Modal'ı kapat
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Uyarı"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
            }
        }
    }
}

// Preview için
struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview'da çalışması için sahte bir TaskListViewModel örneği oluşturuyoruz.
        NewTaskView(taskListVM: TaskListViewModel())
    }
}
