//
//  TotalBalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/9/24.
//

import SwiftUI
import Charts

//struct BalanceChartView: View {
//    
//    var balanceChart : [[Double]]
//    var timeBefore : Date?
//    @State private var startIndex: Int = 0
//    
//    var body: some View {
//        if (balanceChart.isEmpty) {
//            Rectangle()
//                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
//                .frame(height: 250) // Then set the frame
//                .cornerRadius(20) // Apply corner radius after setting the frame
//                .padding(10) // Finally, apply padding
//        } else {
//            Chart {
//                ForEach(startIndex..<balanceChart.count, id: \.self) { index in
//                    let entry = balanceChart[index]
//                    LineMark(
//                        x: .value("Day", entry[0]),
//                        y: .value("Value", entry[1])
//                    )
//                }
//            }
//            .chartXScale(domain: createRange(from: balanceChart[startIndex][0], to: balanceChart[balanceChart.count - 1][0]))
//            .frame(height: 200)
//            .aspectRatio(contentMode: .fit)
//            .padding()
//            .chartYAxis(.hidden)
//            .chartXAxis(.hidden)
//            .foregroundStyle(.green)
//            .onAppear {
//                startIndex = getStartIndex(totalBalanceChart: balanceChart)
//            }
//        }
//
//    }
//    
//    
//    func getStartIndex(totalBalanceChart: [[Double]]) -> Int {
//
//        if let timeBefore = timeBefore {
//            print("timeBefore: \(timeBefore.timeIntervalSince1970 * 1000)")
//        }
//        
//        for (index, data) in totalBalanceChart.enumerated() {
//
//            if let timeBefore = timeBefore{
//                let timestamp = timeBefore.timeIntervalSince1970 * 1000
//                // Use the timestamp as needed
//                if data[0] >= timestamp {
//                    print("data timestamp: \(data[0])")
//                    print(index)
//                    return index
//                }
//            }
//        }
//        
//        return 0
//    }
//}

