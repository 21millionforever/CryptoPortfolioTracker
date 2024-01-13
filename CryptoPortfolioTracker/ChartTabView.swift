//
//  ChartTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/13/24.
//

import SwiftUI

struct ChartTabView: View {
    
    let tabs = ["LIVE", "1D", "1W", "1M", "3M", "All"]
    @Binding var selectedTab: String
    var totalBalanceChart:  [[Double]]
    var isTotalBalanceChartDataLoaded: Bool
    
    var body: some View {
        switch selectedTab {
            case "LIVE":
                Text("LIVE")
            case "1D":
                Text("1D")
            case "1W":
                let currentDate = Date()
                TotalBalanceChartView(totalBalanceChart: totalBalanceChart, timeBefore: Calendar.current.date(byAdding: .day, value: -7, to: currentDate))
            case "1M":
                let currentDate = Date()
                TotalBalanceChartView(totalBalanceChart: totalBalanceChart, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))
            case "3M":
                    let currentDate = Date()
                    TotalBalanceChartView(totalBalanceChart: totalBalanceChart, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))
            case "All":
                AllTimeBalanceChartView(totalBalanceChart: totalBalanceChart, isTotalBalanceChartDataLoaded: isTotalBalanceChartDataLoaded)
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
