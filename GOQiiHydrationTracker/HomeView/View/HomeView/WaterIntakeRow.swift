//
//  WaterIntakeRow.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct WaterIntakeRow: View {
    let quantity: Double
    let timestamp: Date
    
    var body: some View {
        HStack {
            Image(systemName: "drop.fill")
                .foregroundColor(.blue)
                .font(.system(size: 24))
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Amount")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(Int(quantity)) glasses")
                    .font(.headline)
            }
            Spacer()
            Image(systemName: "clock.fill")
                .foregroundColor(.green)
                .font(.system(size: 24))
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Time")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(formatTimestamp(timestamp))
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    private func formatTimestamp(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm a"
        return formatter.string(from: timestamp)
    }
}

#Preview {
    WaterIntakeRow(quantity: 10.0, timestamp: Date.now)
}
