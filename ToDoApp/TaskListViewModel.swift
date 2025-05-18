//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Barış Tekin on 18.05.2025.
//

import Foundation
import Combine //@Published property wrapper'ını kullanabilmek için.

class TaskListViewModel: ObservableObject { //Bu sınıfın SwiftUI tarafından gözlemlenebilir olmasını sağlar. Bir özelliği @Published ile işaretlendiğinde ve bu özellik değiştiğinde, bu ViewModel'i kullanan View'lar otomatik olarak güncellenir.

    @Published var tasks: [Task] = [] //tasks dizisi bizim görevlerimizi tutacak.

    init() {
        // Başlangıçta örnek görevler yükleyelim
        loadSampleTasks()
    }

    func addTask(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedTitle.isEmpty {
            let newTask = Task(title: trimmedTitle)
            tasks.append(newTask)
        }
    }

    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    // Belirli bir görevi silmek için (List'in .onDelete'i IndexSet kullandığı için bu alternatif)
    func deleteTask(task: Task) {
        tasks.removeAll { $0.id == task.id }
    }

    private func loadSampleTasks() {
        // Sadece bu ViewModel oluşturulduğunda örnek verilerle başlasın diye
        // Eğer tasks dizisi zaten doluysa (örneğin başka bir yerden yüklendiyse)
        // tekrar örnek eklememek için kontrol edebiliriz, ama şimdilik basit tutalım.
        // if tasks.isEmpty { // Bu kontrolü ekleyebiliriz, ama şimdilik gerek yok.
            tasks = [
                Task(title: "SwiftUI Temellerini Öğren", isCompleted: true),
                Task(title: "MVVM Mimarisi Çalış"),
                Task(title: "İlk iOS Uygulamamı Yap", isCompleted: false),
                Task(title: "GitHub Kullanımını Pekiştir", isCompleted: true)
            ]
        // }
    }
}
