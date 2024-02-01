//
//  ChartTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/13/24.
//

//TODO: Working on this

import SwiftUI

struct ChartTabView: View {
    
    let balanceChartData: BalanceChartData
    let tabs = ["1D", "1W", "1M", "3M", "All"]
    @Binding var selectedTab: String
    
    var body: some View {
        switch selectedTab {
            case "1D":
//            BalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: isDataLoaded, timeInterval: "1", height: 200)
            Text("Place Holder")

            case "1W":
            VStack {
                Group {
                    if let dataPoints = balanceChartData.oneWeek {
                        let usdDiff = calculatUsdDiff(dataPoints: dataPoints, timeBefore: nil)
                        let percDiff = caculateRateDiff(dataPoints: dataPoints, timeBefore: nil)
                        let iconName = usdDiff.contains("-") ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill"
                        let iconColor = usdDiff.contains("-") ? Color.theme.red : Color.theme.green

                        ChartHeaderView(iconName: iconName, iconColor: iconColor, usdDiff: usdDiff, percDiff: percDiff, timeFrame: "1W")
                    } else {
                        Text("No data available")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.leading)
            
                BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1W", height: 200)
            }
            case "1M":
            VStack {
                Group {
                    let currentDate = Date()
                    Group {
                        if let dataPoints = balanceChartData.all {
                            let usdDiff = calculatUsdDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))
                            let percDiff = caculateRateDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))
                            let iconName = usdDiff.contains("-") ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill"
                            let iconColor = usdDiff.contains("-") ? Color.theme.red : Color.theme.green
                            
                            ChartHeaderView(iconName: iconName, iconColor: iconColor, usdDiff: usdDiff, percDiff: percDiff, timeFrame: "1M")
                        } else {
                            Text("No data available")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.leading)
                    Spacer()

                    BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1M", timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate), height: 200)
                }
            }
            
            case "3M":
            VStack {
                Group {
                    let currentDate = Date()
                    Group {
                        if let dataPoints = balanceChartData.all {
                            let usdDiff = calculatUsdDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))
                            let percDiff = caculateRateDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))
                            let iconName = usdDiff.contains("-") ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill"
                            let iconColor = usdDiff.contains("-") ? Color.theme.red : Color.theme.green
                            
                            ChartHeaderView(iconName: iconName, iconColor: iconColor, usdDiff: usdDiff, percDiff: percDiff, timeFrame: "3M")
                        } else {
                            Text("No data available")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.leading)
                    Spacer()

                    BalanceChartView(balanceChartData: balanceChartData, timeInterval: "3M", timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate), height: 200)
                }
            }
            case "All":
            VStack {
                ChartHeaderView(iconName: "arrowtriangle.up.fill", iconColor: Color.theme.green, usdDiff: balanceChartData.all?.last?.value.asCurrencyWith2Decimals() ?? "$0.00", percDiff: "(100.0%)", timeFrame: "All Time")
                    .padding(.leading)
              
                BalanceChartView(balanceChartData: balanceChartData, timeInterval: "All", height: 200)
            }
            default:
                Text("Defaualt")

        }
        
        
        HStack {
            ForEach(tabs, id: \.self) { tab in
                TabButtonView(tab: tab, selectedTab: $selectedTab)
            }
        }
     
    }

    
    
    
}

extension ChartTabView {
    struct ChartHeaderView: View {
        var iconName: String
        var iconColor: Color
        var usdDiff: String
        var percDiff: String
        var timeFrame: String

        var body: some View {
            HStack(spacing: 3) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(iconColor)

                Text(usdDiff)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(percDiff)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(timeFrame)
                    .font(.subheadline)
                    .fontWeight(.light)

                Spacer()
            }
        }
    }
    
    struct TabButtonView: View {
        let tab: String
        @Binding var selectedTab: String

        var body: some View {
            Button(action: {
                self.selectedTab = tab
            }) {
                Spacer()
                VStack {
                    Text(tab)
                        .foregroundColor(self.selectedTab == tab ? .white : Color.theme.green)
                        .frame(width: 50, height: 30)
                        .background(self.selectedTab == tab ? Color.theme.green : Color.theme.background)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
    
    
    private func getStartIndex(dataPoints: [ChartDataPoint], timeBefore : Date?) -> Int {
        if let timeBefore = timeBefore {
            print("timeBefore: \(timeBefore)")

            for (index, dataPoint) in dataPoints.enumerated() {
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
    
    private func calculatUsdDiff(dataPoints: [ChartDataPoint], timeBefore : Date?) -> String {
        var output: Double
        if let timeBefore = timeBefore {
            let startIndex = getStartIndex(dataPoints: dataPoints, timeBefore: timeBefore)
            if let lastValue = dataPoints.last?.value {
                output = lastValue - dataPoints[startIndex].value
                return String(output.asCurrencyWith2Decimals())
            }
        }
        else {
            if let firstValue = dataPoints.first?.value {
                if let lastValue = dataPoints.last?.value {
                    output = lastValue - firstValue
                    return String(output.asCurrencyWith2Decimals())
                }
            }
        }
        return "Error"
    }
    
    private func caculateRateDiff(dataPoints: [ChartDataPoint], timeBefore : Date?) -> String {
        var output: Double
        if let timeBefore = timeBefore {
            let startIndex = getStartIndex(dataPoints: dataPoints, timeBefore: timeBefore)
            if let lastValue = dataPoints.last?.value {
                let diffUsd = lastValue - dataPoints[startIndex].value
                output = (diffUsd / lastValue) * 100
                return output.asPercentString()
            }
        }
        else {
            if let firstValue = dataPoints.first?.value {
                if let lastValue = dataPoints.last?.value {
                    output = ((lastValue - firstValue) / lastValue) * 100
                    return output.asPercentString()
                }
            }
        }
        return "Error"
    }
}

enum Tab: String, CaseIterable {
    case oneDay = "1D"
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonth = "3M"
    case allTime = "All"
}


//struct ChartTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTabView()
//    }
//}
