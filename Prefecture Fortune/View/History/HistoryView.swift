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
    
    @Query
    var fortuneData: [FortuneData]
    
    var body: some View {
        let groupedItems = Dictionary(grouping: fortuneData) { data in
            return data.date
        }
        
        if fortuneData.isEmpty {
            ContentUnavailableView(
                "Label.NoHistory",
                systemImage: "clock.badge.xmark"
            )
        } else {
            List {
                ForEach(groupedItems.keys.sorted(), id: \.self) { key in
                    Section {
                        ForEach(groupedItems[key] ?? []) { item in
                            HistoryCell(data: item)
                        }
                    } header: {
                        Text(
                            key,
                            format: .dateTime.year().month().day().weekday()
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
