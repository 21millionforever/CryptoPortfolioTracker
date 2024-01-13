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
                .padding(20)
                .frame(height: 250)
                .foregroundColor(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
        
        
    }
}

//struct AllTimeBalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllTimeBalanceChartView()
//    }
//}
