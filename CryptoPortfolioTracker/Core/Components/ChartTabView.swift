//
//  ChartTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/13/24.
//

import SwiftUI

struct ChartTabView: View {
    let balanceChartData: BalanceChartData
    let tabs = ["1W", "1M", "3M", "All"]
    @Binding var selectedTab: String
//    @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel
    
    var body: some View {
        VStack {
            ChartHeaderView(timeFrame: selectedTab)
                .padding(.leading)
            
            selectedView(for: selectedTab)
                .frame(height: 200)
            
            tabButtons
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
                    .foregroundColor(chartHeaderViewModel.usdDiff ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
                    .imageScale(.medium)

                Text(chartHeaderViewModel.usdDiff?.asCurrencyWith2DecimalsWithoutSign() ?? "N/A")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(chartHeaderViewModel.usdDiff ?? 0 >= 0 ? Color.theme.green : Color.theme.red)

                Text("(\(chartHeaderViewModel.percentageDiff?.asPercentStringWithoutSign() ?? "N/A"))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(chartHeaderViewModel.percentageDiff ?? 0 >= 0 ? Color.theme.green : Color.theme.red)

                Text(timeFrame)
                    .font(.subheadline)
                    .fontWeight(.light)
                
                Spacer()
            }
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

#Preview {
    ChartTabView(balanceChartData: BalanceChartData(), selectedTab: .constant("1W"))
}
