//
//  GetWalletHistoricalValueApi.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/8/24.
//

import Foundation

//struct DataPoint: Codable, Identifiable {
//    let id = UUID()
//    let date: String
//    let value: Double
//
//    init(from array: [Any]) throws {
//        guard let date = array[0] as? String, let value = array[1] as? Double else {
//            throw APIError.invalidData
//        }
//        self.date = date
//        self.value = value
//    }
//}

//struct ChartDataPoint: Identifiable {
//    let id = UUID()
//    let date: Date
//    let value: Double
//}
//
//func parseChartData(rawData: [[String]], days: String) -> [ChartDataPoint] {
//    var chartData: [ChartDataPoint] = []
//
//    let dateFormatter = DateFormatter()
//    if (days == "max") {
//        dateFormatter.dateFormat = "MMMM d, yyyy"
//    }
//    else if (days == "7") {
//        dateFormatter.dateFormat = "MMMM d, yyyy, h a"
//    }
//      
//    for item in rawData {
//        if let dateString = item.first,
//           let valueString = item.last,
//           let date = dateFormatter.date(from: dateString),
//           let value = Double(valueString) {
//            let dataPoint = ChartDataPoint(date: date, value: value)
//            chartData.append(dataPoint)
//        }
//    }
//
//    return chartData
//}


//func fetchWalletHistoricalValueChart(walletAddress: String, days: String) async throws -> [ChartDataPoint] {
//    let endpoint = "\(Config.server_url)/getWalletBalanceChart/\(walletAddress)/\(days)"
//
//    guard let url = URL(string: endpoint) else {
//        throw APIError.invalidURL
//    }
//
//    let (data, response) = try await URLSession.shared.data(from: url)
//
//    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//        throw APIError.invalidResponse
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        var raw_data = try decoder.decode([[String]].self, from: data)
//        let output = parseChartData(rawData: raw_data, days: days)
//        return output
//    } catch {
//        throw APIError.invalidData
//    }
//
//}
