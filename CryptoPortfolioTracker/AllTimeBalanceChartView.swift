//
//  AllTimeBalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/9/24.
//

import SwiftUI
import Charts

struct AllTimeBalanceChartView: View {
    var totalBalanceChart : BalanceChartData?
    var isTotalBalanceChartDataLoaded : Bool
    var timeInterval: String
    var width: CGFloat?
    var height: CGFloat

    var body: some View {
        if (isTotalBalanceChartDataLoaded) {
            if (timeInterval == "All") {
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
}


//struct AllTimeBalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllTimeBalanceChartView()
//    }
//}
