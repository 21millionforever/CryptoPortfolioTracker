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
    var chartWidth: CGFloat?
    var chartHeight: CGFloat
    @State private var selectedDataPoint: ChartDataPoint?
    @State private var dragPosition: CGFloat? = nil
    let draggable: Bool
    
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
                        .frame(height: chartHeight)
                        .onAppear {
                            chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: dataPoints)
                        }
                        .gesture(draggable ? dragGesture(dataPoints: dataPoints) : nil)
                        .overlay(draggable ? RectangleOverlayView(dataPoints: dataPoints, dragPosition: dragPosition, selectedDataPoint: $selectedDataPoint) : nil)
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    if(value.location.x <= 10) {
//                                        dragPosition = 10
//                                        return
//                                    }
//                                    else if (value.location.x >= UIScreen.main.bounds.width - 7) {
//                                        dragPosition = UIScreen.main.bounds.width - 7
//                                        return
//                                    }
//                                    else {
//                                        dragPosition = value.location.x
//                                    }
//
//                                    updateSelectedDataPointAndTotalBalance(dataPoints: dataPoints , to: value.location.x)
//
//                                    chartHeaderViewModel.updateHeaderInfo(dataPoints: dataPoints, selectedDataPoint: selectedDataPoint)
//
//                                }
//                                .onEnded { _ in
//                                    dragPosition = nil
//                                    chartHeaderViewModel.setHeaderInfoToDefault(dataPoints: dataPoints)
//
//                                    Task {
//                                        await balanceChartViewModel.loadTotalBalance()
//                                    }
//                                }
//                        )
//                        .overlay(
//                            RectangleOverlayView(dataPoints: dataPoints, dragPosition: dragPosition, selectedDataPoint: $selectedDataPoint)
//                        )
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(Color.theme.green)
            }
            
            else if (timeInterval == "3M") {
                VStack {
                    if let dataPoints = balanceChartData.threeMonth {
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
                        .frame(height: chartHeight)
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
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .foregroundStyle(Color.theme.green)
            }
            else if (timeInterval == "1M") {
                VStack {
                    if let dataPoints = balanceChartData.oneMonth {
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
                        .frame(height: chartHeight)
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
                        .frame(height: chartHeight)
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
        }
        else {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2)) // Set the color first
                .frame(height: 250) // Then set the frame
                .cornerRadius(20) // Apply corner radius after setting the frame
                .padding(10) // Finally, apply padding
        }
    }
    
    func updateSelectedDataPointAndTotalBalance(dataPoints: [ChartDataPoint], to dragPosition: CGFloat) {
        // Convert drag position to chart data point
        let index = Int( (dragPosition - 10) / (UIScreen.main.bounds.width - 20) * CGFloat(dataPoints.count - 1))
        
        let dataPoint = index >= 0 && index < dataPoints.count ? dataPoints[index] : dataPoints[dataPoints.count - 1]
        
        DispatchQueue.main.async {
            self.selectedDataPoint = dataPoint
            balanceChartViewModel.balance = dataPoint.value
        }
    }

    
}

func createRange(from: Date, to: Date) -> ClosedRange<Date> {
    return from...to
}

struct RectangleOverlayView: View {
    let dataPoints: [ChartDataPoint]
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


extension BalanceChartView {
    
    private func dragGesture(dataPoints: [ChartDataPoint]) -> some Gesture {
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
        
        
    }
    
}


//struct BalanceChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BalanceChartView()
//    }
//}



