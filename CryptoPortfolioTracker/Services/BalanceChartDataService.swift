//
//  BalanceChartDataService.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation

class BalanceChartDataService {
    
    /**
     Fetch chart data
     
     This function takes a wallet address and the time frame of chart data you want to fetch
     
     - Parameters:
       - walletAddress:  a wallet address
       - days:  Chart time frame
     - Returns: [ChartDataPoint]
    */
    func fetchWalletChartData(walletAddress: String, days: String) async throws -> [ChartDataPoint] {
        let endpoint = "\(Config.server_url)/getWalletBalanceChart/\(walletAddress)/\(days)"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        let raw_data: [[String]] = try await NetworkingManager.fetchData(from: url)
        
        return parseChartData(rawData: raw_data, days: days)
    }
    
    private func parseChartData(rawData: [[String]], days: String) -> [ChartDataPoint] {
        var chartData: [ChartDataPoint] = []
        
        let dateFormatter = DateFormatter()
        if (days == "max") {
            dateFormatter.dateFormat = "MMMM d, yyyy"
        }
        else if (days == "7") {
            dateFormatter.dateFormat = "MMMM d, yyyy, h a"
        }
        
        for item in rawData {
            if let dateString = item.first,
               let valueString = item.last,
               let date = dateFormatter.date(from: dateString),
               let value = Double(valueString) {
                let dataPoint = ChartDataPoint(date: date, value: value)
                chartData.append(dataPoint)
            }
        }
        
        return chartData
    }
}
