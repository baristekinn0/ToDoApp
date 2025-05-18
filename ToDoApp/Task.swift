//
//  Task.swift
//  ToDoApp
//
//  Created by Barış Tekin on 18.05.2025.
//

import Foundation

// Görevleri temsil edecek veri modeli
struct Task: Identifiable, Codable {
    var id: UUID = UUID()         // Her görev için benzersiz bir kimlik
    var title: String             // Görevin başlığı
    var isCompleted: Bool = false // Görev tamamlandı mı? (Varsayılan olarak false)

    // (İsteğe bağlı, ileride ekleyebiliriz)
    // var dueDate: Date?         // Görevin son tarihi (opsiyonel)
    // var priority: Priority = .medium // Görevin önceliği (enum tanımlayabiliriz)
}

// (İleride öncelik için kullanabileceğimiz bir enum örneği)
/*
enum Priority: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case low = "Düşük"
    case medium = "Orta"
    case high = "Yüksek"
}
*/
