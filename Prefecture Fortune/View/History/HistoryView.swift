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
    
    @Query(sort: \FortuneData.date)
    var fortuneData: [FortuneData]
    
    @State var viewModel = HistoryViewModel()
    
    var body: some View {
        if fortuneData.isEmpty {
            ContentUnavailableView(
                "Label.NoHistory",
                systemImage: "clock.badge.xmark"
            )
        } else {
            List {
                ForEach(viewModel.sectionaizedData.keys.sorted(), id: \.self) { key in
                    Section {
                        ForEach(viewModel.sectionaizedData[key] ?? []) { item in
                            Button {
                                viewModel.showSheet(for: item)
                            } label: {
                                HistoryCell(data: item)
                            }
                        }
                        .onDelete(perform: deleteData(at:))
                    } header: {
                        Text(key, format: .dateTime.year().month().day())
                    }
                }
            }
            .sheet(item: $viewModel.fortuneResult) { result in
                ResultView(result: result)
            }
            .onAppear {
                viewModel.sectionzeData(data: fortuneData)
            }
            .onChange(of: fortuneData) { _, newValue in
                viewModel.sectionzeData(data: newValue)
            }
        }
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
