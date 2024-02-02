//
//  ChartTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/13/24.
//

//TODO: Working on this

//import SwiftUI
//
//struct ChartTabView: View {
//
//    let balanceChartData: BalanceChartData
//    let tabs = ["1D", "1W", "1M", "3M", "All"]
//    @Binding var selectedTab: String
//    @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel
//
//    var body: some View {
//        switch selectedTab {
//            case "1W":
//            VStack {
//                Group {
//                        ChartHeaderView(timeFrame: "1W")
//
//                }
//                .padding(.leading)
//
//                BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1W", height: 200)
//            }
//            case "1M":
//            VStack {
//                Group {
//                    let currentDate = Date()
//                    ChartHeaderView(timeFrame: "1M")
//                        .padding(.leading)
//                    Spacer()
//
//                    BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1M", timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate), height: 200)
//                }
//            }
//
//            case "3M":
//            VStack {
//                Group {
//                    let currentDate = Date()
//                    ChartHeaderView(timeFrame: "3M")
//                        .padding(.leading)
//                    Spacer()
//
//                    BalanceChartView(balanceChartData: balanceChartData, timeInterval: "3M", timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate), height: 200)
//                }
//            }
//            case "All":
//            VStack {
//                ChartHeaderView(timeFrame: "All Time")
//                    .padding(.leading)
//                BalanceChartView(balanceChartData: balanceChartData, timeInterval: "All", height: 200)
//            }
//            default:
//                Text("Defaualt")
//
//        }
//
//
//        HStack {
//            ForEach(tabs, id: \.self) { tab in
//                TabButtonView(tab: tab, selectedTab: $selectedTab)
//            }
//        }
//
//    }
//
//
//
//
//}
//
//extension ChartTabView {
//    struct ChartHeaderView: View {
//        var timeFrame: String
//        @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel
//
//        var body: some View {
//            HStack(spacing: 3) {
//                Image(systemName: chartHeaderViewModel.usdDiff ?? 0 >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 15, height: 15)
//                    .foregroundColor(chartHeaderViewModel.usdDiff ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
//
//                Text(chartHeaderViewModel.usdDiff?.asCurrencyWith2Decimals() ?? "Error")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//
//                Text(chartHeaderViewModel.percentageDiff?.asPercentString() ?? "Error")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//
//                Text(timeFrame)
//                    .font(.subheadline)
//                    .fontWeight(.light)
//
//                Spacer()
//            }
//        }
//    }
//
//    struct TabButtonView: View {
//        let tab: String
//        @Binding var selectedTab: String
//
//        var body: some View {
//            Button(action: {
//                self.selectedTab = tab
//            }) {
//                Spacer()
//                VStack {
//                    Text(tab)
//                        .foregroundColor(self.selectedTab == tab ? .white : Color.theme.green)
//                        .frame(width: 50, height: 30)
//                        .background(self.selectedTab == tab ? Color.theme.green : Color.theme.background)
//                        .cornerRadius(10)
//                }
//                Spacer()
//            }
//        }
//    }
//
//
//    private func getStartIndex(dataPoints: [ChartDataPoint], timeBefore : Date?) -> Int {
//        if let timeBefore = timeBefore {
//            print("timeBefore: \(timeBefore)")
//
//            for (index, dataPoint) in dataPoints.enumerated() {
//                // Use the date directly for comparison
//                if dataPoint.date >= timeBefore {
//                    return index
//                }
//            }
//        }
//
//        return 0
//    }
//}
//

import SwiftUI

struct ChartTabView: View {
    let balanceChartData: BalanceChartData
    let tabs = ["1D", "1W", "1M", "3M", "All"]
    @Binding var selectedTab: String
    @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel
    
    var body: some View {
        VStack {
            ChartHeaderView(timeFrame: selectedTab)
                .padding(.leading)
            
            selectedView(for: selectedTab)
                .frame(height: 200)
            
            tabButtons
        }
    }
    
    @ViewBuilder
    private func selectedView(for tab: String) -> some View {
        let currentDate = Date()
        switch tab {
        case "1W":
            BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1W", chartHeight: 200, draggable: true)
        case "1M":
            BalanceChartView(balanceChartData: balanceChartData, timeInterval: "1M", chartHeight: 200, draggable: true)
        case "3M":
            BalanceChartView(balanceChartData: balanceChartData, timeInterval: "3M", chartHeight: 200, draggable: true)
        case "All":
            BalanceChartView(balanceChartData: balanceChartData, timeInterval: "All", chartHeight: 200, draggable: true)
        default:
            Text("Please select a time frame")
        }
    }
    
    private var tabButtons: some View {
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
                    .foregroundColor(chartHeaderViewModel.usdDiff ?? 0 >= 0 ? .green : .red)
                    .imageScale(.medium)

                Text(chartHeaderViewModel.usdDiff?.asCurrencyWith2Decimals() ?? "N/A")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(chartHeaderViewModel.percentageDiff?.asPercentString() ?? "N/A")
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
                Text(tab)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(selectedTab == tab ? .white : Color.theme.green)
                    .background(
                                       
                        Rectangle() // or Rectangle()
                            .foregroundColor(selectedTab == tab ? Color.theme.green : Color.theme.background)
                            .frame(width: 50, height: 30)
                            .cornerRadius(10)
                    )
                    
            }
        }
    }
}

// Helper extensions for formatting (assuming these are implemented)


//struct ChartTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTabView()
//    }
//}
