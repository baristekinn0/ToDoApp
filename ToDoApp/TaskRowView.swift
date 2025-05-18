//
//  TaskRowView.swift
//  ToDoApp
//
//  Created by Barış Tekin on 18.05.2025.
//

import SwiftUI

struct TaskRowView: View {
    // Bu View'ın bir Task objesi alacağını belirtiyoruz.
    // @Binding kullanacağız çünkü görevin 'isCompleted' durumunu
    // bu View üzerinden değiştirebilmek istiyoruz ve bu değişiklik
    // ana listedeki orijinal Task objesine yansımalı.
    @Binding var task: Task

    var body: some View {
        HStack {
            // Görevin tamamlanma durumunu gösteren ve değiştiren bir Toggle
            Toggle(isOn: $task.isCompleted) {
                Text(task.title)
                    .strikethrough(task.isCompleted, color: .gray) // Tamamlandıysa üstünü çiz
                    .foregroundColor(task.isCompleted ? .gray : .primary) // Rengini ayarla
            }
            // Toggle'ın etiketini kullanmak yerine kendi Text'imizi kullandık.
            // Toggle'ın kendisi sadece checkbox gibi davranacak.
            // Eğer Toggle'ın kendi label'ını kullanmak isterseniz:
            /*
            Toggle(isOn: $task.isCompleted) {
                Text(task.title)
            }
            .strikethrough(task.isCompleted, color: .gray)
            .foregroundColor(task.isCompleted ? .gray : .primary)
            */

            // VEYA daha basit bir yaklaşım: Bir daire ve metin
            /*
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .gray)
                .onTapGesture {
                    task.isCompleted.toggle()
                }
            Text(task.title)
                .strikethrough(task.isCompleted, color: .gray)
                .foregroundColor(task.isCompleted ? .gray : .primary)
            Spacer() // Eğer metin solda, ikon sağda olsun istenirse
             */
        }
        .padding(.vertical, 4) // Satırlar arasına biraz boşluk
    }
}

// Preview (Önizleme) için örnek bir Task oluşturmamız gerekiyor.
// @State wrapper'ı, Preview içinde @Binding gereksinimini karşılamak için kullanılır.
struct TaskRowView_Previews: PreviewProvider {
    @State static var sampleTask1 = Task(title: "Örnek Tamamlanmış Görev", isCompleted: true)
    @State static var sampleTask2 = Task(title: "Örnek Tamamlanmamış Görev", isCompleted: false)

    static var previews: some View {
        VStack {
            TaskRowView(task: $sampleTask1)
            TaskRowView(task: $sampleTask2)
        }
        .padding()
    }
}
