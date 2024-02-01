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
    @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel
    
    var body: some View {
        switch selectedTab {
//            case "1D":
////            BalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: isDataLoaded, timeInterval: "1", height: 200)
//            Text("Place Holder")

//            case "1W":
//            VStack {
//                Group {
//                    if let dataPoints = balanceChartData.oneWeek {
//                        let usdDiff = calculatUsdDiff(dataPoints: dataPoints, timeBefore: nil)
//                        let percDiff = caculateRateDiff(dataPoints: dataPoints, timeBefore: nil)
//                        let iconName = usdDiff.contains("-") ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill"
//                        let iconColor = usdDiff.contains("-") ? Color.theme.red : Color.theme.green
//
//                        ChartHeaderView(iconName: iconName, iconColor: iconColor, usdDiff: usdDiff, percDiff: percDiff, timeFrame: "1W")
//                    } else {
//                        Text("No data available")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                    }
//                }
//                .padding(.leading)
//
//                BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1W", height: 200)
//            }
//            case "1M":
//            VStack {
//                Group {
//                    let currentDate = Date()
//                    ChartHeaderView(usdDiff: usdDiff ?? 0.00, percDiff: percDiff ?? 0.00, timeFrame: "1M")
//                        .padding(.leading)
//                    Spacer()
//
//                    BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1M", timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate), height: 200, usdDiff: $usdDiff, percDiff: $percDiff)
//                }
//            }
//
//            case "3M":
//            VStack {
//                Group {
//                    let currentDate = Date()
//                    ChartHeaderView(usdDiff: usdDiff ?? 0.00, percDiff: percDiff ?? 0.00, timeFrame: "3M")
//                        .padding(.leading)
//                    Spacer()
//
//                    BalanceChartView(balanceChartData: balanceChartData, timeInterval: "3M", timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate), height: 200, usdDiff: $usdDiff, percDiff: $percDiff)
//                }
//            }
            case "All":
            VStack {
                ChartHeaderView(timeFrame: "All Time")
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
        var timeFrame: String
        @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel

        var body: some View {
            HStack(spacing: 3) {
                Image(systemName: chartHeaderViewModel.usdDiff ?? 0 >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(chartHeaderViewModel.usdDiff ?? 0 >= 0 ? Color.theme.green : Color.theme.red)

                Text(chartHeaderViewModel.usdDiff?.asCurrencyWith2Decimals() ?? "Error")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(chartHeaderViewModel.percentageDiff?.asPercentString() ?? "Error")
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
