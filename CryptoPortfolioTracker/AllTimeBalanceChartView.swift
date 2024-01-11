//
//  AllTimeBalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/9/24.
//

import SwiftUI
import Charts

struct AllTimeBalanceChartView: View {
    @State var totalBalanceChart : [[Double]]
    
    var body: some View {
        HStack {
            Chart {
                ForEach(0..<totalBalanceChart.count, id: \.self) { index in
                    let entry = totalBalanceChart[index]
                    LineMark(
                        x: .value("Day", entry[0]),
                        y: .value("Value", entry[1])
                    )
                }
            }
            .chartXScale(domain: createRange(from: totalBalanceChart[0][0], to: totalBalanceChart[totalBalanceChart.count - 1][0]))
            .frame(height: 200)
            .aspectRatio(contentMode: .fit)
            .padding()
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .foregroundStyle(.green)
    }
}

//struct AllTimeBalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllTimeBalanceChartView()
//    }
//}
