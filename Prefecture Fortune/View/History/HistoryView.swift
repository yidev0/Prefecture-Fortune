//
//  HistoryView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \FortuneData.date, order: .reverse)
    var fortuneData: [FortuneData]
    
    var body: some View {
        if fortuneData.isEmpty {
            ContentUnavailableView(
                "Label.NoHistory",
                systemImage: "clock.badge.xmark"
            )
        } else {
            List {
                ForEach(Array(groupedItems.keys), id: \.self) { key in
                    Section {
                        ForEach(groupedItems[key] ?? []) { item in
                            HistoryCell(data: item)
                        }
                        .onDelete(perform: deleteData(at:))
                    } header: {
                        Text(key)
                    }
                }
            }
        }
    }
    
    private var groupedItems: [String: [FortuneData]] {
        Dictionary(grouping: fortuneData) { item in
            formatDate(item.date)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func deleteData(at offsets: IndexSet) {
        for offset in offsets {
            let data = fortuneData[offset]
            context.delete(data)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

#Preview {
    HistoryView()
}
