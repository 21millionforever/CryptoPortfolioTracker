//
//  ChartTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/13/24.
//

import SwiftUI

struct ChartTabView: View {
    
    let tabs = ["1D", "1W", "1M", "3M", "All"]
    @Binding var selectedTab: String
    var balanceChart:  BalanceChartData
    var isDataLoaded: Bool
    
//    var currentDate: String {
//            let now = Date()
//            let formatter = DateFormatter()
//            formatter.dateStyle = .medium
//            return formatter.string(from: now)
//    }
//
    var body: some View {
        switch selectedTab {
//            case "LIVE":
//                Text("LIVE")
            case "1D":
            AllTimeBalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: isDataLoaded, timeInterval: "1", height: 200)
                
            case "1W":
            AllTimeBalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: isDataLoaded, timeInterval: "7", height: 200)
            case "1M":
                let currentDate = Date()
            BalanceChartView(balanceChart: balanceChart.all ?? [], timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))
            case "3M":
                let currentDate = Date()
                BalanceChartView(balanceChart: balanceChart.all ?? [], timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))
            case "All":
            AllTimeBalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: isDataLoaded, timeInterval: "All", height: 200)
            default:
                Text("Defaualt")

        }
        
        VStack {
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Button(action: {
                        self.selectedTab = tab
                    }) {
                        Spacer()
                        VStack {
                            Text(tab)
                                .foregroundColor(self.selectedTab == tab ? .white : .green)
                                .frame(width: 50, height: 30)
                                .background(self.selectedTab == tab ? .green : .white)
                                .cornerRadius(10)

                        }
                        Spacer()
                    }

                }
            }
        }
    }
}

//struct ChartTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTabView()
//    }
//}
