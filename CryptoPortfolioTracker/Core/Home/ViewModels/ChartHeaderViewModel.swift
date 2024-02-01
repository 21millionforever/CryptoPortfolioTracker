//
//  ChartHeaderViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 2/1/24.
//

import Foundation

class ChartHeaderViewModel: ObservableObject {
    @Published var usdDiff: Double?
    @Published var percentageDiff: Double?
    
    func updateHeaderInfo(dataPoints: [ChartDataPoint], selectedDataPoint: ChartDataPoint?) {
        guard let selectedDataPointValue = selectedDataPoint?.value else {
            return
        }
        
        guard let firstValue = dataPoints.first?.value else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.usdDiff = selectedDataPointValue - firstValue
            self?.percentageDiff = (selectedDataPointValue - firstValue) / firstValue * 100
        }
        
        print("First value: \(firstValue), selected value: \(selectedDataPointValue), USD diff: \(self.usdDiff?.asNumberString() ?? "Error"), Percentage diff: \(self.percentageDiff?.asPercentString() ?? "Error")")
    }
    
    func setHeaderInfoToDefault(dataPoints: [ChartDataPoint]) {
        DispatchQueue.main.async { [weak self] in
            let lastValue = dataPoints.last?.value ?? 0.00
            let firstValue = dataPoints.first?.value ?? 0.00
            self?.usdDiff = lastValue - firstValue

            // Avoid division by zero
            if let firstValueNonZero = dataPoints.first?.value, firstValueNonZero != 0 {
                self?.percentageDiff = (lastValue - firstValue) / firstValueNonZero * 100
            } else {
                self?.percentageDiff = 0 // or some default value to indicate error or undefined
            }
        }
    }
}
