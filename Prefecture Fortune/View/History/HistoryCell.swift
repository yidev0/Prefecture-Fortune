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
            Text(data.response.name)
                .fontWeight(.semibold)
            
            HStack {
                Text(data.request.name)
                if let date = data.request.birthday.makeDate() {
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
