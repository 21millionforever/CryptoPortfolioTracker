//
//  BalanceChartViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/21/24.
//

import Foundation
import SwiftUI

class BalanceChartViewModel: ObservableObject {
    @Published var walletToBalanceChart = [String: BalanceChartData]()
    @Published var totalBalanceChart = BalanceChartData()
    @Published var isTotalBalanceChartDataLoaded = false
    @Published var totalBalance: Double = 0
    
    private let chartDataService = BalanceChartDataService()
    
    /**
     Update totalBalance
     
     This function updates totalBalance by assigning the value of self?.totalBalanceChart.all?.last?.value to totalBalance
     
     - Parameters: Doesn't need an input
     - Returns: Doesn't return anything
    */
    func loadTotalBalance() async {
        DispatchQueue.main.async { [weak self] in
            self?.totalBalance = self?.totalBalanceChart.all?.last?.value ?? 0.00
        }
    }
    
    /**
     Populate walletToBalanceChart and totalBalanceChart
     
     This function takes a list of wallet addresses
     
     - Parameters:
       - addresses:  a list of wallet addresses
     - Returns: Doesn't return anything
    */
    func loadChartData(addresses: [String]) async {
        await withTaskGroup(of: (String, BalanceChartData).self) { group in
            for address in addresses {
                let lowerCaseAddress = address.lowercased()
                group.addTask {
                    do {
                        let currentDate = Date()
                        
                        // Get the max chart for the wallet address
                        let tempMaxBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "max")
                        
                        // Get the chart for the last three monthes for the wallet address
                        let threeMonthStartIndex = self.getStartIndex(dataPoints: tempMaxBalanceChart, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))
                        let tempThreeMonthBalanceChart = Array(tempMaxBalanceChart.suffix(from: threeMonthStartIndex))
                        
                        // Get the chart for the last month for the wallet address
                        let oneMonthStartIndex = self.getStartIndex(dataPoints: tempMaxBalanceChart, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))
                        let tempOneMonthBalanceChart = Array(tempMaxBalanceChart.suffix(from: oneMonthStartIndex))
                        
                        // Get the chart for the last week for the wallet address
                        let tempOneWeekBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "7")
                        
                        // Get the chart for the day for the wallet addresss
                        // let tempOneDayBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "1")
                        
                        return (lowerCaseAddress, BalanceChartData(all: tempMaxBalanceChart, threeMonth: tempThreeMonthBalanceChart, oneMonth: tempOneMonthBalanceChart, oneWeek: tempOneWeekBalanceChart))
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
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let tempMaxChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "max")
                let tempThreeMonthChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "threeMonth")
                let tempOneMonthChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "oneMonth")
                let tempOneWeekChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "7")
                // let tempOneDayChartData = self.CalculateTotalBalanceChart(walletToBalanceChart: self.walletToBalanceChart, timeInterval: "1")
                
                self.totalBalanceChart.all = tempMaxChartData
                self.totalBalanceChart.threeMonth = tempThreeMonthChartData
                self.totalBalanceChart.oneMonth = tempOneMonthChartData
                self.totalBalanceChart.oneWeek = tempOneWeekChartData
//                self.totalBalanceChart.oneday = tempOneDayChartData
                self.isTotalBalanceChartDataLoaded = true
            }
        }
    }
    
    /**
     Update walletToBalanceChart and totalBalanceChart
     
     This function takes a wallet address, and then update walletToBalanceChart and totalBalanceChart
     
     - Parameters:
       - address: A wallet address
     - Returns: Doesn't return anything
    */
    func loadSingleAddressChartData(address: String) async {
        let lowerCaseAddress = address.lowercased()
        let currentDate = Date()
        do {
            let tempMaxBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "max")
            
            let threeMonthStartIndex = self.getStartIndex(dataPoints: tempMaxBalanceChart, timeBefore: Calendar.current.date(byAdding: .month, value: -3, to: currentDate))
            let tempThreeMonthBalanceChart = Array(tempMaxBalanceChart.suffix(from: threeMonthStartIndex))
            
            let oneMonthStartIndex = self.getStartIndex(dataPoints: tempMaxBalanceChart, timeBefore: Calendar.current.date(byAdding: .month, value: -1, to: currentDate))
            let tempOneMonthBalanceChart = Array(tempMaxBalanceChart.suffix(from: oneMonthStartIndex))
            
            let tempOneWeekBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress, days: "7")
            // let tempOneDayBalanceChart = try await fetchWalletHistoricalValueChart(walletAddress: lowerCaseAddress, days: "1")
            
            let chartData = BalanceChartData(all: tempMaxBalanceChart, threeMonth: tempThreeMonthBalanceChart, oneMonth: tempOneMonthBalanceChart, oneWeek: tempOneWeekBalanceChart)
            
            DispatchQueue.main.async { [weak self] in
                self?.walletToBalanceChart[lowerCaseAddress] = chartData

                // Calculate the total balance chart
                let tempMaxChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "max")
                let tempThreeMonthChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "threeMonth")
                let tempOneMonthChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "oneMonth")
                let tempOneWeekChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "7")
                // let tempOneDayChartData = CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "1")

                self?.totalBalanceChart.all = tempMaxChartData
                self?.totalBalanceChart.threeMonth = tempThreeMonthChartData
                self?.totalBalanceChart.oneMonth = tempOneMonthChartData
                self?.totalBalanceChart.oneWeek = tempOneWeekChartData
//                self?.totalBalanceChart.oneday = tempOneDayChartData
                self?.isTotalBalanceChartDataLoaded = true
            }
            
        } catch {
            print("Error fetching data for address \(lowerCaseAddress): \(error)")
        }
    }
    
    /**
     Computes the sum of the balance charts of all the wallets
     
     This function takes in a dicionary of {wallet address: BalanceChartData}, and a string, which determines which time frame chart to combine, and return a sorted and combined chart
     - Parameters:
       - walletToBalanceChart: {wallet address: BalanceChartData} wall addresses map to their corresponding BalanceChartData
       - timeInterval: determines which time frame chart to combine
     - Returns: a sorted and combined ChartDataPoint object
    */
    func CalculateTotalBalanceChart(walletToBalanceChart : [String: BalanceChartData], timeInterval: String) -> [ChartDataPoint] {
        var combinedData = [Date: Double]()
        
        
        for (address, balanceChartData) in walletToBalanceChart {
            if (timeInterval == "max") {
                if let dataPoints = balanceChartData.all {
                    for dataPoint in dataPoints {
                        combinedData[dataPoint.date, default: 0] += dataPoint.value
                    }
                }
            }
            
            else if (timeInterval == "threeMonth") {
                if let dataPoints = balanceChartData.threeMonth {
                    for dataPoint in dataPoints {
                        combinedData[dataPoint.date, default: 0] += dataPoint.value
                    }
                }
            }
            
            else if (timeInterval == "oneMonth") {
                if let dataPoints = balanceChartData.oneMonth {
                    for dataPoint in dataPoints {
                        combinedData[dataPoint.date, default: 0] += dataPoint.value
                    }
                }
            }
            
            
            else if (timeInterval == "7") {
                if let dataPoints = balanceChartData.oneWeek {
                    for dataPoint in dataPoints {
                        combinedData[dataPoint.date, default: 0] += dataPoint.value
                    }
                }
            }
            
//            else if (timeInterval == "1") {
//                if let dataPoints = balanceChartData.oneDay {
//                    for dataPoint in dataPoints {
//                        combinedData[dataPoint.date, default: 0] += dataPoint.value
//                    }
//                }
//            }
            
            
            
            
        }
        
        let unsortedDataPoints = combinedData.map { ChartDataPoint(date: $0.key, value: $0.value) }
        let sortedDataPoints = unsortedDataPoints.sorted { $0.date < $1.date }

        return sortedDataPoints

    }
    
    /**
     Get the start index in a list of data points
     
     This function takes a list of ChartDataPoint objects and a Date? object and find the start index.
     
     - Parameters:
       - dataPoints: a list of ChartDataPoint objects
       - timeBefore: A Date object.
     - Returns: An index that is an int
    */
    func getStartIndex(dataPoints: [ChartDataPoint], timeBefore: Date?) -> Int {
        if let timeBefore = timeBefore {
            print("timeBefore: \(timeBefore)")

            for (index, dataPoint) in dataPoints.enumerated() {
                // Use the date directly for comparison
                if dataPoint.date >= timeBefore {
                    return index
                }
            }
        }
        
        return 0
    }
}
    


