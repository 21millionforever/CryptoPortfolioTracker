//
//  AllTimeBalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/9/24.
//

import SwiftUI
import Charts

struct AllTimeBalanceChartView: View {
    var totalBalanceChart : [[Double]]?
    var isTotalBalanceChartDataLoaded : Bool
    
    var body: some View {
        if (isTotalBalanceChartDataLoaded) {
            HStack {
                Chart {
                    ForEach(0..<(totalBalanceChart?.count ?? 0), id: \.self) { index in
                        if let entry = totalBalanceChart?[index], entry.count >= 2 {
                            LineMark(
                                x: .value("Day", entry[0]),
                                y: .value("Value", entry[1])
                            )
                        }
                    }
                }
                .chartXScale(domain: createRange(from: totalBalanceChart?.first?.first ?? 0, to: totalBalanceChart?.last?.first ?? 200))
                .frame(height: 200)
                .aspectRatio(contentMode: .fit)
                .padding()
            }
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
            .foregroundStyle(.green)
        }
        else {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 250) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10) // Finally, apply padding
        }
    }
}

//struct AllTimeBalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllTimeBalanceChartView()
//    }
//}
