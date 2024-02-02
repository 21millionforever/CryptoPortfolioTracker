//
//  BalanceChartView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/18/24.
//

import SwiftUI
import Charts

struct BalanceChartView: View {
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel
    @EnvironmentObject var chartHeaderViewModel: ChartHeaderViewModel
    let balanceChartData: BalanceChartData
    var timeInterval: String
    var timeBefore : Date?
    @State private var startIndex: Int = 0
    var width: CGFloat?
    var height: CGFloat
    @State private var selectedDataPoint: ChartDataPoint?
    @State private var dragPosition: CGFloat? = nil
    let dragable: Bool
    
    var body: some View {
        if (balanceChartViewModel.isTotalBalanceChartDataLoaded) {
            if (timeInterval == "All") {
                VStack {
                    if let dataPoints = balanceChartData.all {
                        Chart {
                            ForEach(dataPoints) { dataPoint in
                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .padding([.leading, .trailing], CGFloat(10))
                        .chartXScale(domain: createRange(from: dataPoints.first?.date ?? Date(), to: dataPoints.last?.date ?? Date()))
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .onAppear {
                            chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: dataPoints)
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if(value.location.x <= 10) {
                                        dragPosition = 10
                                        return
                                    }
                                    else if (value.location.x >= UIScreen.main.bounds.width - 7) {
                                        dragPosition = UIScreen.main.bounds.width - 7
                                        return
                                    }
                                    else {
                                        dragPosition = value.location.x
                                    }
                                    
                                    updateSelectedDataPointAndTotalBalance(dataPoints: dataPoints , to: value.location.x)
                                    
                                    chartHeaderViewModel.updateHeaderInfo(dataPoints: dataPoints, selectedDataPoint: selectedDataPoint)
                
                                }
                                .onEnded { _ in
                                    dragPosition = nil
                                    chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: dataPoints)
                                 
                                    Task {
                                        await balanceChartViewModel.loadTotalBalance()
                                    }
                                }
                        )
                        .overlay(
                            RectangleOverlayView(dataPoints: dataPoints, dragPosition: dragPosition, selectedDataPoint: $selectedDataPoint)
                        )
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(Color.theme.green)
            }
            
            else if (timeInterval == "3M") {
                VStack {
                    if let dataPoints = balanceChartData.all {
                        Chart {
                            ForEach(dataPoints.suffix(from: startIndex), id: \.id) { dataPoint in

                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .padding([.leading, .trailing], CGFloat(10))
                        .chartXScale(domain: createRange(from: dataPoints[startIndex].date, to: dataPoints[dataPoints.count - 1].date))
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .onAppear {
                            startIndex = getStartIndex(totalBalanceChart: dataPoints)
                            chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: Array(dataPoints.suffix(from: startIndex)))
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if(value.location.x <= 10) {
                                        dragPosition = 10
                                        return
                                    }
                                    else if (value.location.x >= UIScreen.main.bounds.width - 7) {
                                        dragPosition = UIScreen.main.bounds.width - 7
                                        return
                                    }
                                    else {
                                        dragPosition = value.location.x
                                    }
                                    updateSelectedDataPointAndTotalBalance(dataPoints: Array(dataPoints.suffix(from: startIndex)) , to: value.location.x)
                                    
                                    chartHeaderViewModel.updateHeaderInfo(dataPoints: Array(dataPoints.suffix(from: startIndex)), selectedDataPoint: selectedDataPoint)
                                    
                                   
                                }
                                .onEnded { _ in
                                    dragPosition = nil
                                    chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: Array(dataPoints.suffix(from: startIndex)))
                               
                                    Task {
                                        await balanceChartViewModel.loadTotalBalance()
                                    }
                                }
                        )
                        .overlay(
                            RectangleOverlayView(dataPoints: Array(dataPoints.suffix(from: startIndex)), startIndex: startIndex , dragPosition: dragPosition, selectedDataPoint: $selectedDataPoint)
                        )
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(Color.theme.green)
            }
            else if (timeInterval == "1M") {
                VStack {
                    if let dataPoints = balanceChartData.all {
                        Chart {
                            ForEach(dataPoints.suffix(from: startIndex), id: \.id) { dataPoint in

                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .padding([.leading, .trailing], CGFloat(10))
                        .chartXScale(domain: createRange(from: dataPoints[startIndex].date, to: dataPoints[dataPoints.count - 1].date))
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .onAppear {
                            startIndex = getStartIndex(totalBalanceChart: dataPoints)
                            chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: Array(dataPoints.suffix(from: startIndex)))
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if(value.location.x <= 10) {
                                        dragPosition = 10
                                        return
                                    }
                                    else if (value.location.x >= UIScreen.main.bounds.width - 7) {
                                        dragPosition = UIScreen.main.bounds.width - 7
                                        return
                                    } else {
                                        dragPosition = value.location.x
                                    }
                                    updateSelectedDataPointAndTotalBalance(dataPoints: Array(dataPoints.suffix(from: startIndex)), to: value.location.x)
                                    
                                    chartHeaderViewModel.updateHeaderInfo(dataPoints: Array(dataPoints.suffix(from: startIndex)), selectedDataPoint: selectedDataPoint)


                                }
                                .onEnded { _ in
                                    dragPosition = nil
                                    chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: Array(dataPoints.suffix(from: startIndex)))
                                    Task {
                                        await balanceChartViewModel.loadTotalBalance()
                                    }
                                }
                        )
                        .overlay(
                            RectangleOverlayView(dataPoints: Array(dataPoints.suffix(from: startIndex)), startIndex: startIndex , dragPosition: dragPosition, selectedDataPoint: $selectedDataPoint)
                        )
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(Color.theme.green)
            }
            else if (timeInterval == "1W") {
                VStack {
                    if let dataPoints = balanceChartData.oneWeek {
                        Chart {
                            ForEach(dataPoints) { dataPoint in
                                LineMark(
                                    x: .value("Day", dataPoint.date),
                                    y: .value("Value", dataPoint.value)
                                )
                            }
                        }
                        .padding([.leading, .trailing], CGFloat(10))
                        .chartXScale(domain: createRange(from: dataPoints.first?.date ?? Date(), to: dataPoints.last?.date ?? Date()))
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .onAppear {
                            chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: dataPoints)
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if(value.location.x <= 10) {
                                        dragPosition = 10
                                        return
                                    }
                                    else if (value.location.x >= UIScreen.main.bounds.width - 7) {
                                        dragPosition = UIScreen.main.bounds.width - 7
                                        return
                                    } else {
                                        dragPosition = value.location.x
                                    }
                                    
                                    updateSelectedDataPointAndTotalBalance(dataPoints: dataPoints , to: value.location.x)
                                    
                                    chartHeaderViewModel.updateHeaderInfo(dataPoints: dataPoints, selectedDataPoint: selectedDataPoint)
                                    
                                    
                                }
                                .onEnded { _ in
                                    dragPosition = nil
                                    chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: dataPoints)
                                    Task {
                                        await balanceChartViewModel.loadTotalBalance()
                                    }
                                }
                        )
                        .overlay(
                            RectangleOverlayView(dataPoints: dataPoints, dragPosition: dragPosition, selectedDataPoint: $selectedDataPoint)
                        )
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(Color.theme.green)
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
                    return index
                }
            }
        }
        
        return 0
    }
    
    func updateSelectedDataPointAndTotalBalance(dataPoints: [ChartDataPoint], to dragPosition: CGFloat) {
        // Convert drag position to chart data point
        let index = Int( (dragPosition - 10) / (UIScreen.main.bounds.width - 20) * CGFloat(dataPoints.count - 1))
        
        let dataPoint = index >= 0 && index < dataPoints.count ? dataPoints[index] : dataPoints[dataPoints.count - 1]
        
        DispatchQueue.main.async {
            self.selectedDataPoint = dataPoint
            balanceChartViewModel.totalBalance = dataPoint.value
        }
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


struct RectangleOverlayView: View {
    let dataPoints: [ChartDataPoint]
    var startIndex: Int?
    var dragPosition: CGFloat?
    @Binding var selectedDataPoint: ChartDataPoint?
    @EnvironmentObject var balanceChartViewModel: BalanceChartViewModel

    var body: some View {
        GeometryReader { geometry in
            if let dragPosition = dragPosition {
                // Draw the vertical line
                VStack {
                    Text("\(selectedDataPoint?.date.asMediumDateString() ?? "Error")")
                        .font(.caption2)
                    Rectangle()
                        .fill(Color.theme.secondaryText)
                        .frame(width: 2)
                }

                .offset(x: dragPosition - 35, y: 0)
                .foregroundColor(Color.theme.secondaryText)
                
            }
        }

    }
}




