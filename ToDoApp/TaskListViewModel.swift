//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Barış Tekin on 18.05.2025.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {

    @Published var tasks: [Task] = []
    private let tasksStorageKey = "savedTasksArray" // UserDefaults için anahtar

    init() {
        // Uygulama başlarken kayıtlı görevleri yükle
        loadTasks()
    }

    // --- CRUD Fonksiyonları ---

    func addTask(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedTitle.isEmpty {
            let newTask = Task(title: trimmedTitle)
            tasks.append(newTask)
            saveTasks() // Görev eklendikten sonra kaydet
        }
    }

    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks() // Görev durumu değiştiktan sonra kaydet
        }
    }

//    func deleteTask(at offsets: IndexSet) {
//        tasks.remove(atOffsets: offsets)
//        saveTasks() // Görev silindikten sonra kaydet
//    }

    // TaskListViewModel.swift
    func deleteTask(at offsets: IndexSet) {
        // ... (önceki print'ler) ...

        print("Offsetler geçerli görünüyor, silme işlemi yapılacak.")
        objectWillChange.send() // Değişiklikten hemen önce haber ver
        tasks.remove(atOffsets: offsets)
        print("Silme sonrası tasks count: \(tasks.count)")
        saveTasks()
        print("--- deleteTask(at offsets: IndexSet) BİTTİ (BAŞARILI) ---")
    }
    
    // Belirli bir görevi ID ile silmek için (eğer kullanılıyorsa)
    func deleteTask(task: Task) {
        tasks.removeAll { $0.id == task.id }
        saveTasks() // Görev silindikten sonra kaydet
    }


    // --- Veri Kalıcılığı Fonksiyonları (UserDefaults) ---

    private func saveTasks() {
        // Görevleri JSON formatına çevirip UserDefaults'a kaydet
        // Task struct'ımız Codable olduğu için bu işlem kolay.
        do {
            let encodedTasks = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedTasks, forKey: tasksStorageKey)
            print("Görevler başarıyla UserDefaults'a kaydedildi. Kaydedilen görev sayısı: \(tasks.count)")
        } catch {
            print("Görevler kaydedilirken hata oluştu: \(error.localizedDescription)")
        }
    }

    private func loadTasks() {
        // UserDefaults'tan kayıtlı görevleri yükle
        guard let savedTasksData = UserDefaults.standard.data(forKey: tasksStorageKey) else {
            print("UserDefaults'ta kayıtlı görev bulunamadı. Örnek görevler yüklenecek.")
            // Eğer kayıtlı görev yoksa, örnek görevleri yükleyebilir veya boş başlatabiliriz.
            // loadSampleTasks() // İsteğe bağlı: ilk çalıştırmada örnek görevlerle başla
            self.tasks = [] // Veya boş bir dizi ile başla
            return
        }

        do {
            let decodedTasks = try JSONDecoder().decode([Task].self, from: savedTasksData)
            self.tasks = decodedTasks
            print("Görevler UserDefaults'tan başarıyla yüklendi. Yüklenen görev sayısı: \(tasks.count)")
        } catch {
            print("Kaydedilmiş görevler decode edilirken hata oluştu: \(error.localizedDescription). Örnek görevler yüklenecek veya boş başlatılacak.")
            // Hata durumunda da örnek görev yükleyebilir veya boş başlatabiliriz.
            // loadSampleTasks()
            self.tasks = []
        }
    }

    // Örnek görevleri yükleme fonksiyonu (artık sadece ilk çalıştırma veya hata durumunda kullanılabilir)
    // Bu fonksiyonu artık doğrudan init içinde çağırmıyoruz.
    /*
    private func loadSampleTasks() {
        tasks = [
            Task(title: "SwiftUI Temellerini Öğren", isCompleted: true),
            Task(title: "MVVM Mimarisi Çalış"),
            Task(title: "İlk iOS Uygulamamı Yap", isCompleted: false),
            Task(title: "GitHub Kullanımını Pekiştir", isCompleted: true)
        ]
        print("Örnek görevler yüklendi.")
    }
    */
}
