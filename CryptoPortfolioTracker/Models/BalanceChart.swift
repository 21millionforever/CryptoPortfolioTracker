//
//  BalanceChart.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/27/24.
//

import Foundation


struct BalanceChartData: Hashable {
    var all: [ChartDataPoint]?
    var oneWeek: [ChartDataPoint]?
    var oneDay: [ChartDataPoint]?
    var live: [ChartDataPoint]?
}

struct ChartDataPoint: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let value: Double
}
