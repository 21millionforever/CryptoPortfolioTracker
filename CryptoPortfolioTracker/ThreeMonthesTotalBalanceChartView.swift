//
//  ThreeMonthesTotalBalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/9/24.
//

import SwiftUI
import Charts

struct ThreeMonthesTotalBalanceChartView: View {
    
    var totalBalanceChart : [[Double]]
    
    @State private var startIndex: Int = 0
    
    var body: some View {
        HStack {
            Chart {
                ForEach(startIndex..<totalBalanceChart.count, id: \.self) { index in
                    let entry = totalBalanceChart[index]
                    LineMark(
                        x: .value("Day", entry[0]),
                        y: .value("Value", entry[1])
                    )
                }
            }
            .chartXScale(domain: createRange(from: totalBalanceChart[startIndex][0], to: totalBalanceChart[totalBalanceChart.count - 1][0]))
            .frame(height: 200)
            .aspectRatio(contentMode: .fit)
            .padding()
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .foregroundStyle(.green)
        .onAppear {
            startIndex = getStartIndex(totalBalanceChart: totalBalanceChart)
        }
    }
    

    func getStartIndex(totalBalanceChart: [[Double]]) -> Int {
        let currentDate = Date()
        let threeMonthsBefore = Calendar.current.date(byAdding: .month, value: -3, to: currentDate)
//        let threeMonthsBefore = Calendar.current.date(byAdding: .day, value: -20, to: currentDate)
        if let threeMonthsBefore = threeMonthsBefore {
            print("threeMonthsBefore: \(threeMonthsBefore.timeIntervalSince1970 * 1000)")
        }
        
        
        
        for (index, data) in totalBalanceChart.enumerated() {

            if let threeMonthsBefore = threeMonthsBefore {
                let timestamp = threeMonthsBefore.timeIntervalSince1970 * 1000
                // Use the timestamp as needed
                print("data timestamp: \(data[0])")
                if data[0] >= timestamp {
                    print(index)
                    return index
                }
            }

        }
        print(0)
        
        return 0
    }
}

//struct ThreeMonthesTotalBalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThreeMonthesTotalBalanceChartView()
//    }
//}
