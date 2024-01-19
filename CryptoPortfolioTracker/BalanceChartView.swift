//
//  BalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/18/24.
//

import SwiftUI
import Charts

struct BalanceChartView: View {
    var totalBalanceChart : BalanceChartData?
   
    var isTotalBalanceChartDataLoaded : Bool
    var timeInterval: String
    var timeBefore : Date?
    @State private var startIndex: Int = 0
    var width: CGFloat?
    var height: CGFloat

    var body: some View {
        if (isTotalBalanceChartDataLoaded) {
            if (timeInterval == "All") {
                VStack {
                    HStack {
                        Chart {
                                if let dataPoints = totalBalanceChart?.all {
                                    ForEach(0..<(dataPoints.count), id: \.self) { index in
                                        let entry = dataPoints[index]
                                        if entry.count >= 2 {
                                            LineMark(
                                                x: .value("Day", entry[0]),
                                                y: .value("Value", entry[1])
                                            )
                                        }

                                    }
                                }
                        }
                        .chartXScale(domain: createRange(from: totalBalanceChart?.all?.first?.first ?? 0, to: totalBalanceChart?.all?.last?.first ?? 200))
                        .frame(width: width ?? nil, height: height)
                        .aspectRatio(contentMode: .fit)
                        .padding()


                    }
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                    .foregroundStyle(.green)
                }
            }
            else if (timeInterval == "1M") {
                if let dataPoints = totalBalanceChart?.all {
                    Chart {
                        ForEach(startIndex..<dataPoints.count, id: \.self) { index in
                            let entry = dataPoints[index]
                            LineMark(
                                x: .value("Day", entry[0]),
                                y: .value("Value", entry[1])
                            )
                        }
                    }
                    .chartXScale(domain: createRange(from: dataPoints[startIndex][0], to: dataPoints[dataPoints.count - 1][0]))
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                    .foregroundStyle(.green)
                    .onAppear {
                        startIndex = getStartIndex(totalBalanceChart: dataPoints)
                    }
                }
            }
            else if (timeInterval == "3M") {
                if let dataPoints = totalBalanceChart?.all {
                    Chart {
                        ForEach(startIndex..<dataPoints.count, id: \.self) { index in
                            let entry = dataPoints[index]
                            LineMark(
                                x: .value("Day", entry[0]),
                                y: .value("Value", entry[1])
                            )
                        }
                    }
                    .chartXScale(domain: createRange(from: dataPoints[startIndex][0], to: dataPoints[dataPoints.count - 1][0]))
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                    .foregroundStyle(.green)
                    .onAppear {
                        startIndex = getStartIndex(totalBalanceChart: dataPoints)
                    }
                }
            }
            else if (timeInterval == "7") {
                HStack {
                    Chart {
                            if let dataPoints = totalBalanceChart?.oneWeek {
                                ForEach(0..<(dataPoints.count), id: \.self) { index in
                                    let entry = dataPoints[index]
                                    if entry.count >= 2 {
                                        LineMark(
                                            x: .value("Day", entry[0]),
                                            y: .value("Value", entry[1])
                                        )
                                    }

                                }
                            }
                    }
                    .chartXScale(domain: createRange(from: totalBalanceChart?.oneWeek?.first?.first ?? 0, to: totalBalanceChart?.oneWeek?.last?.first ?? 200))
                    .frame(height: height)
                    .aspectRatio(contentMode: .fit)
                    .padding()


                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(.green)
            }
            else if (timeInterval == "1") {
                HStack {
                    Chart {
                            if let dataPoints = totalBalanceChart?.oneDay {
                                ForEach(0..<(dataPoints.count), id: \.self) { index in
                                    let entry = dataPoints[index]
                                    if entry.count >= 2 {
                                        LineMark(
                                            x: .value("Day", entry[0]),
                                            y: .value("Value", entry[1])
                                        )
                                    }

                                }
                            }
                    }
                    .chartXScale(domain: createRange(from: totalBalanceChart?.oneDay?.first?.first ?? 0, to: totalBalanceChart?.oneDay?.last?.first ?? 200))
                    .frame(height: height)
                    .aspectRatio(contentMode: .fit)
                    .padding()


                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(.green)
            }

        }
        else {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 250) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10) // Finally, apply padding
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
        
        return 0
    }
    
}



//struct BalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BalanceChartView()
//    }
//}
