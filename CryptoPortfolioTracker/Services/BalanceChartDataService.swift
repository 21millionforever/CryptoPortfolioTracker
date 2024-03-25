//
//  BalanceChartDataService.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation
import OSLog


class BalanceChartDataService {
    
    /**
     Fetch chart data
     
     This function takes a wallet address and the time frame of chart data you want to fetch
     
     - Parameters:
       - walletAddress:  a wallet address
       - days:  Chart time frame
     - Returns: [ChartDataPoint]
    */
    func fetchWalletChartData(walletAddress: String) async throws -> [ChartDataPoint] {
        let endpoint = "\(Config.server_url)/getWalletBalanceChart/\(walletAddress)"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
     
        let raw_data: [Dictionary<String, Double>] = try await NetworkingManager.fetchData(from: url)
        logger.log("tempMaxBalanceChart(rawData):\(raw_data)")
        
        let output = parseChartData(rawData: raw_data)
        return output
    }
    
    private func parseChartData(rawData: [Dictionary<String, Double>]) -> [ChartDataPoint] {
        var chartData: [ChartDataPoint] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        for dictionary in rawData {
            for (dateString, value) in dictionary {
                if let date = dateFormatter.date(from: dateString) {
                    let dataPoint = ChartDataPoint(date: date, value: value)
                    chartData.append(dataPoint)
                }
            }
        }
        return chartData
        
    }
}
