//
//  ChartTabView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/13/24.
//

import SwiftUI

struct ChartTabView: View {
    
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel
    let tabs = ["1D", "1W", "1M", "3M", "All"]
    @Binding var selectedTab: String
    
    var body: some View {
        switch selectedTab {
            case "1D":
//            BalanceChartView(totalBalanceChart: balanceChart, isTotalBalanceChartDataLoaded: isDataLoaded, timeInterval: "1", height: 200)
            Text("Place Holder")

            case "1W":
            VStack {
                HStack(spacing: 3) {
                    if let dataPoints = balanceChartViewModel.totalBalanceChart.oneWeek {
                        let usdDiff = calculatUsdDiff(dataPoints: dataPoints, timeBefore: nil)
                        let usdRateDiff = caculateRateDiff(dataPoints: dataPoints, timeBefore: nil)

                        if usdDiff.contains("-") {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "arrowtriangle.up.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.green)
                        }

                        Text(usdDiff)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("\(usdRateDiff)")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("1W")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    else {
                        Text("Unknown")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }

                    Spacer()

                }
                .padding(.leading)

                BalanceChartView(timeInterval: "1W", height: 200)
            }
            case "1M":
            VStack {
                let currentDate = Date()

                HStack(spacing: 3) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)

                    if let dataPoints = balanceChartViewModel.totalBalanceChart.all {
                        Text(calculatUsdDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate)))
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("(\(caculateRateDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))))")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("1M")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    else {
                        Text("Unknown")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }


                    Spacer()

                }
                .padding(.leading)

                BalanceChartView(timeInterval: "1M", timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate), height: 200)
            }
            
            case "3M":
            VStack {
                let currentDate = Date()
                HStack(spacing: 3) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)

                    if let dataPoints = balanceChartViewModel.totalBalanceChart.all {
                        Text(calculatUsdDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate)))
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("(\(caculateRateDiff(dataPoints: dataPoints, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))))")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("3M")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    else {
                        Text("Unknown")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }


                    Spacer()

                }
                .padding(.leading)
                BalanceChartView(timeInterval: "3M", timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate), height: 200)
            }
            case "All":
            VStack {
                HStack(spacing: 3) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)

                    Text(formatAsCurrency(number: balanceChartViewModel.totalBalanceChart.all?.last?.value))
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("(100.0%)")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("All Time")
                        .font(.subheadline)
                        .fontWeight(.light)

                    Spacer()

                }
                .padding(.leading)
              
                BalanceChartView(timeInterval: "All", height: 200)
            }
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
    
    func getStartIndex(dataPoints: [ChartDataPoint], timeBefore : Date?) -> Int {
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
    
    
    func calculatUsdDiff(dataPoints: [ChartDataPoint], timeBefore : Date?) -> String {
        var output: Double
        if let timeBefore = timeBefore {
            let startIndex = getStartIndex(dataPoints: dataPoints, timeBefore: timeBefore)
            if let lastValue = dataPoints.last?.value {
                output = lastValue - dataPoints[startIndex].value
                return String(formatAsCurrency(number: output))
            }
        }
        else {
            if let firstValue = dataPoints.first?.value {
                if let lastValue = dataPoints.last?.value {
                    output = lastValue - firstValue
                    return String(formatAsCurrency(number: output))
                }
            }
        }
        return "Error"
    }
    
    func caculateRateDiff(dataPoints: [ChartDataPoint], timeBefore : Date?) -> String {
        var output: Double
        if let timeBefore = timeBefore {
            let startIndex = getStartIndex(dataPoints: dataPoints, timeBefore: timeBefore)
            if let lastValue = dataPoints.last?.value {
                let diffUsd = lastValue - dataPoints[startIndex].value
                output = (diffUsd / lastValue)
                return formatAsPercentage(number: output)
            }
        }
        else {
            if let firstValue = dataPoints.first?.value {
                if let lastValue = dataPoints.last?.value {
                    output = ((lastValue - firstValue) / lastValue)
                    return formatAsPercentage(number: output)
                }
            }
        }
        return "Error"
    }
    
    
}



//struct ChartTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTabView()
//    }
//}
