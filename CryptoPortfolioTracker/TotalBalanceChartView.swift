//
//  TotalBalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/9/24.
//

import SwiftUI
import Charts

struct TotalBalanceChartView: View {
    
    var totalBalanceChart : [[Double]]
    var timeBefore : Date?
    @State private var startIndex: Int = 0
    
    var body: some View {
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
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
            .foregroundStyle(.green)
            .onAppear {
                startIndex = getStartIndex(totalBalanceChart: totalBalanceChart)
            }
    }
    
    func getStartIndex(totalBalanceChart: [[Double]]) -> Int {

        if let timeBefore = timeBefore {
            print("timeBefore: \(timeBefore.timeIntervalSince1970 * 1000)")
        }
        
        for (index, data) in totalBalanceChart.enumerated() {

            if let timeBefore = timeBefore{
                let timestamp = timeBefore.timeIntervalSince1970 * 1000
                // Use the timestamp as needed
                if data[0] >= timestamp {
                    print("data timestamp: \(data[0])")
                    print(index)
                    return index
                }
            }

        }
        print(0)
        
        return 0
    }
}

//struct TotalBalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        TotalBalanceChartView()
//    }
//}
