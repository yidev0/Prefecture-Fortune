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
                Text(data.request.name)
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HistoryCell(data: .sample)
}
