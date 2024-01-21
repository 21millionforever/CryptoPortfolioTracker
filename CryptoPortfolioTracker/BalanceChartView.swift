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
                    if let dataPoints = totalBalanceChart?.all {
                        Chart {
                            ForEach(dataPoints) { dataPoint in
                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .chartXScale(domain: createRange(from: dataPoints.first?.date ?? Date(), to: dataPoints.last?.date ?? Date()))
                        .frame(maxWidth: .infinity) // Use maximum width available
                        .frame(height: height)
                        .padding()
                    }
                }
                .edgesIgnoringSafeArea(.horizontal) // Extend to the horizontal edges of the screen
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(.green)
            }
            else if (timeInterval == "3M") {
                VStack {
                    if let dataPoints = totalBalanceChart?.all {
                        Chart {
                            ForEach(dataPoints.suffix(from: startIndex), id: \.id) { dataPoint in

                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .chartXScale(domain: createRange(from: dataPoints[startIndex].date, to: dataPoints[dataPoints.count - 1].date))
                        .frame(maxWidth: .infinity) // Use maximum width available
                        .frame(height: height)
                        .padding()
                        .onAppear {
                            startIndex = getStartIndex(totalBalanceChart: dataPoints)
                        }
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(.green)
            }
            else if (timeInterval == "1M") {
                VStack {
                    if let dataPoints = totalBalanceChart?.all {
                        Chart {
                            ForEach(dataPoints.suffix(from: startIndex), id: \.id) { dataPoint in

                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .chartXScale(domain: createRange(from: dataPoints[startIndex].date, to: dataPoints[dataPoints.count - 1].date))
                        .frame(maxWidth: .infinity) // Use maximum width available
                        .frame(height: height)
                        .padding()
                        .onAppear {
                            startIndex = getStartIndex(totalBalanceChart: dataPoints)
                        }
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(.green)
            }
            else if (timeInterval == "1W") {
                VStack {
                    if let dataPoints = totalBalanceChart?.oneWeek {
                        Chart {
                            ForEach(dataPoints) { dataPoint in
                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .chartXScale(domain: createRange(from: dataPoints.first?.date ?? Date(), to: dataPoints.last?.date ?? Date()))
                        .frame(maxWidth: .infinity) // Use maximum width available
                        .frame(height: height)
                        .padding()
                    }
                }
                .edgesIgnoringSafeArea(.horizontal) // Extend to the horizontal edges of the screen
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(.green)
                
                
//                HStack {
//                    Chart {
//                            if let dataPoints = totalBalanceChart?.oneWeek {
//                                ForEach(0..<(dataPoints.count), id: \.self) { index in
//                                    let entry = dataPoints[index]
//                                    if entry.count >= 2 {
//                                        LineMark(
//                                            x: .value("Day", entry[0]),
//                                            y: .value("Value", entry[1])
//                                        )
//                                    }
//
//                                }
//                            }
//                    }
//                    .chartXScale(domain: createRange(from: totalBalanceChart?.oneWeek?.first?.first ?? 0, to: totalBalanceChart?.oneWeek?.last?.first ?? 200))
//                    .frame(height: height)
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
//
//
//                }
//                .chartYAxis(.hidden)
//                .chartXAxis(.hidden)
//                .foregroundStyle(.green)
            }
//            else if (timeInterval == "1") {
//                HStack {
//                    Chart {
//                            if let dataPoints = totalBalanceChart?.oneDay {
//                                ForEach(0..<(dataPoints.count), id: \.self) { index in
//                                    let entry = dataPoints[index]
//                                    if entry.count >= 2 {
//                                        LineMark(
//                                            x: .value("Day", entry[0]),
//                                            y: .value("Value", entry[1])
//                                        )
//                                    }
//
//                                }
//                            }
//                    }
//                    .chartXScale(domain: createRange(from: totalBalanceChart?.oneDay?.first?.first ?? 0, to: totalBalanceChart?.oneDay?.last?.first ?? 200))
//                    .frame(height: height)
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
//
//
//                }
//                .chartYAxis(.hidden)
//                .chartXAxis(.hidden)
//                .foregroundStyle(.green)
//            }

        }
        else {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 250) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10) // Finally, apply padding
        }
    }
    
    func getStartIndex(totalBalanceChart: [ChartDataPoint]) -> Int {
        if let timeBefore = timeBefore {
            print("timeBefore: \(timeBefore)")

            for (index, dataPoint) in totalBalanceChart.enumerated() {
                // Use the date directly for comparison
                if dataPoint.date >= timeBefore {
//                    print("data date: \(dataPoint.date)")
//                    print(index)
                    return index
                }
            }
        }
        
        return 0
    }
    
}

func createRange(from: Date, to: Date) -> ClosedRange<Date> {
    return from...to
}

//struct BalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BalanceChartView()
//    }
//}
