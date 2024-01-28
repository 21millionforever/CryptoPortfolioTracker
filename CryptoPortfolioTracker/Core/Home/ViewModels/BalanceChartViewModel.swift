//
//  BalanceChartViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/21/24.
//

import Foundation


class BalanceChartViewModel: ObservableObject {
    @Published var walletToBalanceChart = [String: BalanceChartData]()
    @Published var totalBalanceChart = BalanceChartData()
    @Published var isTotalBalanceChartDataLoaded = false
    @Published var totalBalance: Double = 0
    private let chartDataService = BalanceChartDataService()
    
    func loadTotalBalance() async {
        DispatchQueue.main.async { [weak self] in
            self?.totalBalance = self?.totalBalanceChart.all?.last?.value ?? 0.00
        }
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
                        let tempMaxBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "max")
                        let tempOneWeekBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "7")
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
            let tempMaxBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "max")
            let tempOneWeekBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "7")
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
    


