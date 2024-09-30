//
//  HistoryCell.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import SwiftUI

struct HistoryCell: View {
    
    let data: FortuneData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(data.prefectureName)
                .fontWeight(.semibold)
            
            HStack {
                Text(data.name)
                if let date = data.birthday.makeDate() {
                    Text(date, format: .dateTime.year().month().day())
                }
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HistoryCell(data: .sample)
}
