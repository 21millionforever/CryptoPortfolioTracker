//
//  BalanceChartViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/21/24.
//

import Foundation

struct BalanceChartData {
    var all: [ChartDataPoint]?
    var oneWeek: [ChartDataPoint]?
    var oneDay: [ChartDataPoint]?
    var live: [ChartDataPoint]?
}

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

class BalanceChartViewModel: ObservableObject {
    @Published var addresses: [String] = ["0x98BEe23f076bE7B00fA0A2e243f821EE1344De77"]
    // TODO: 暂时commnet掉
//    {
        // The didSet observer on addresses saves the new value to UserDefaults whenever the addresses array changes.
//        didSet {
//            UserDefaults.standard.set(addresses, forKey: "addresses")
//        }
//    }
    @Published var walletToBalanceChart = [String: BalanceChartData]()
    @Published var totalBalanceChart = BalanceChartData()
    @Published var isTotalBalanceChartDataLoaded = false
    
    init() {
        // TODO: 暂时commnet掉
//        addresses = UserDefaults.standard.object(forKey: "addresses") as? [String] ?? []
        
        if (!(self.addresses.isEmpty)) {
            Task {
                await loadChartData(addresses: addresses)
            }
        }
    }
    
    func fetchWalletHistoricalValueChart(walletAddress: String, days: String) async throws -> [ChartDataPoint] {
        let endpoint = "\(Config.server_url)/getWalletBalanceChart/\(walletAddress)/\(days)"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let raw_data = try decoder.decode([[String]].self, from: data)
            let output = parseChartData(rawData: raw_data, days: days)
            return output
        } catch {
            throw APIError.invalidData
        }
        
    }
    func parseChartData(rawData: [[String]], days: String) -> [ChartDataPoint] {
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
    
    func CalculateTotalBalanceChart(walletToBalanceChart : [String: BalanceChartData], timeInterval: String) -> [ChartDataPoint] {
        var combinedData = [Date: Double]()
        
        
        for (_, balanceChartData) in walletToBalanceChart {
            if (timeInterval == "max") {
                if let maxBalanceChartData = balanceChartData.all {
                    for dataPoint in maxBalanceChartData {
                        combinedData[dataPoint.date, default: 0] += dataPoint.value
                    }
                }
            }
            else if (timeInterval == "7") {
                if let maxBalanceChartData = balanceChartData.oneWeek {
                    for dataPoint in maxBalanceChartData {
                        combinedData[dataPoint.date, default: 0] += dataPoint.value
                    }
                }
            }
        }
        
        let unsortedDataPoints = combinedData.map { ChartDataPoint(date: $0.key, value: $0.value) }
        let sortedDataPoints = unsortedDataPoints.sorted { $0.date < $1.date }

        return sortedDataPoints

    }
    
    func loadChartData(addresses: [String]) async {
        
        await withTaskGroup(of: (String, BalanceChartData).self) { group in
            for address in addresses {
                let lowerCaseAddress = address.lowercased()
                group.addTask {
                    do {
                        let tempMaxBalanceChart = try await self.fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "max")
                        let tempOneWeekBalanceChart = try await self.fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "7")
                        // let tempOneDayBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "1")
                        return (lowerCaseAddress, BalanceChartData(all: tempMaxBalanceChart, oneWeek: tempOneWeekBalanceChart))
                    } catch {
                        print("Error fetching data for address \(lowerCaseAddress): \(error)")
                        return (lowerCaseAddress, BalanceChartData())
                    }
                }
            }
            
            for await (address, chartData) in group {
                DispatchQueue.main.async { [weak self] in
                    self?.walletToBalanceChart[address] = chartData
                }
            }
            
            // Move the calculation here, inside the task group closure
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let tempMaxChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "max")
                let tempOneWeekChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "7")
                // let tempOneDayChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "1")
                
                self.totalBalanceChart.all = tempMaxChartData
                self.totalBalanceChart.oneWeek = tempOneWeekChartData
                self.isTotalBalanceChartDataLoaded = true
            }
        }
    }
    
    func loadSingleAddressChartData(address: String) async {
        let lowerCaseAddress = address.lowercased()
        do {
            let tempMaxBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "max")
            let tempOneWeekBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "7")
            // let tempOneDayBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "1")
            
            let chartData = BalanceChartData(all: tempMaxBalanceChart, oneWeek: tempOneWeekBalanceChart)
            
            DispatchQueue.main.async { [weak self] in
                self?.walletToBalanceChart[lowerCaseAddress] = chartData

                // Calculate the total balance chart
                let tempMaxChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "max")
                let tempOneWeekChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "7")
                // let tempOneDayChartData = CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "1")

                self?.totalBalanceChart.all = tempMaxChartData
                self?.totalBalanceChart.oneWeek = tempOneWeekChartData
                self?.isTotalBalanceChartDataLoaded = true
            }
            
        } catch {
            print("Error fetching data for address \(lowerCaseAddress): \(error)")
        }
    }
}
    


