//
//  BalanceChartViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/21/24.
//

import Foundation
import SwiftUI
import OSLog

let logger = Logger(subsystem: "BalanceChart", category: "BalanceChartDataLoading")


/// A view model for balance chart
///
/// This class is responsible for requesting and storing data for balance chart.  The class doesn't load anything when it's initialized.
class BalanceChartViewModel: ObservableObject {
    @Published var walletToBalanceChart = [String: BalanceChartData]()
    @Published var totalBalanceChart = BalanceChartData()
    @Published var isTotalBalanceChartDataLoaded = false
    @Published var balance: Double = 0
    
    private let chartDataService = BalanceChartDataService()
    
    /**
     Update update balance
     
     This function updates balance(Double) by assigning the value of self?.totalBalanceChart.all?.last?.value to totalBalance
     
     - Parameters: Doesn't need an input
     - Returns: Doesn't return anything
    */
    func loadTotalBalance() async {
        DispatchQueue.main.async { [weak self] in
            self?.balance = self?.totalBalanceChart.all?.last?.value ?? 0.00
        }
    }

    /**
     Populate walletToBalanceChart([String: BalanceChartData]) and totalBalanceChart(BalanceChartData)
     
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
                        // Get the max chart for the wallet address
                        var tempMaxBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress)
                        tempMaxBalanceChart.reverse()
                        logger.log("tempMaxBalanceChart([ChartDataPoint]): \(tempMaxBalanceChart)")
                        logger.log("tempMaxBalanceChart's length: \(tempMaxBalanceChart.count)")
                        
                        // Get the chart for the last three monthes for the wallet address
                        var tempThreeMonthBalanceChart: [ChartDataPoint] = []
                        if tempMaxBalanceChart.count >= 91 {
                            tempThreeMonthBalanceChart = Array(tempMaxBalanceChart.suffix(91))
                        } else {
                            tempThreeMonthBalanceChart = tempMaxBalanceChart
                        }
                        logger.log("tempThreeMonthBalanceChart: \(tempThreeMonthBalanceChart)")
                        logger.log("tempThreeMonthBalanceChart's length: \(tempThreeMonthBalanceChart.count)")
                        
                        // Get the chart for the last month for the wallet address
                        var tempOneMonthBalanceChart: [ChartDataPoint] = []
                        if tempMaxBalanceChart.count >= 30 {
                            tempOneMonthBalanceChart = Array(tempMaxBalanceChart.suffix(30))
                        } else {
                            tempOneMonthBalanceChart = tempMaxBalanceChart
                        }
                        logger.log("tempOneMonthBalanceChart: \(tempOneMonthBalanceChart)")
                        logger.log("tempOneMonthBalanceChart's length: \(tempOneMonthBalanceChart.count)")
                        
                        
                        // Get the chart for the last week for the wallet address
                        var tempOneWeekBalanceChart: [ChartDataPoint] = []
                        if tempMaxBalanceChart.count >= 7 {
                            tempOneWeekBalanceChart = Array(tempMaxBalanceChart.suffix(7))
                        } else {
                            tempOneWeekBalanceChart = tempMaxBalanceChart
                        }
                        logger.log("tempOneWeekBalanceChart: \(tempOneWeekBalanceChart)")
                        logger.log("tempOneWeekBalanceChart's length: \(tempOneWeekBalanceChart.count)")
                        
                        
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
                
                self.totalBalanceChart.all = tempMaxChartData
                self.totalBalanceChart.threeMonth = tempThreeMonthChartData
                self.totalBalanceChart.oneMonth = tempOneMonthChartData
                self.totalBalanceChart.oneWeek = tempOneWeekChartData
                self.isTotalBalanceChartDataLoaded = true
            }
//            print("\(totalBalanceChart.all!)")
//            logger.log("self.totalBalanceChart.all: \(self.totalBalanceChart.all!)")
//            logger.log("self.totalBalanceChart.threeMonth: \(self.totalBalanceChart.threeMonth!)")
//            logger.log("self.totalBalanceChart.oneMonth: \(self.totalBalanceChart.oneMonth!)")
//            logger.log("self.totalBalanceChart.oneWeek: \(self.totalBalanceChart.oneWeek!)")
            
            
            
            
            
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
        
        
        for (_, balanceChartData) in walletToBalanceChart {
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

        }
        
        let unsortedDataPoints = combinedData.map { ChartDataPoint(date: $0.key, value: $0.value) }
        let sortedDataPoints = unsortedDataPoints.sorted { $0.date < $1.date }

        return sortedDataPoints

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
        do {
            // Get the max chart for the wallet address
            var tempMaxBalanceChart = try await self.chartDataService.fetchWalletChartData(walletAddress: lowerCaseAddress)
            tempMaxBalanceChart.reverse()
            
            // Get the chart for the last three monthes for the wallet address
            var tempThreeMonthBalanceChart: [ChartDataPoint] = []
            if tempMaxBalanceChart.count >= 91 {
                tempThreeMonthBalanceChart = Array(tempMaxBalanceChart.suffix(91))
            } else {
                tempThreeMonthBalanceChart = tempMaxBalanceChart
            }
            
            // Get the chart for the last month for the wallet address
            var tempOneMonthBalanceChart: [ChartDataPoint] = []
            if tempMaxBalanceChart.count >= 30 {
                tempOneMonthBalanceChart = Array(tempMaxBalanceChart.suffix(30))
            } else {
                tempOneMonthBalanceChart = tempMaxBalanceChart
            }
            
            
            // Get the chart for the last week for the wallet address
            var tempOneWeekBalanceChart: [ChartDataPoint] = []
            if tempMaxBalanceChart.count >= 7 {
                tempOneWeekBalanceChart = Array(tempMaxBalanceChart.suffix(7))
            } else {
                tempOneWeekBalanceChart = tempMaxBalanceChart
            }
            
            let chartData = BalanceChartData(all: tempMaxBalanceChart, threeMonth: tempThreeMonthBalanceChart, oneMonth: tempOneMonthBalanceChart, oneWeek: tempOneWeekBalanceChart)
            
            
            DispatchQueue.main.async { [weak self] in
                self?.walletToBalanceChart[lowerCaseAddress] = chartData

                // Calculate the total balance chart
                let tempMaxChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "max")
                let tempThreeMonthChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "threeMonth")
                let tempOneMonthChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "oneMonth")
                let tempOneWeekChartData = self?.CalculateTotalBalanceChart(walletToBalanceChart: self?.walletToBalanceChart ?? [:], timeInterval: "7")

                self?.totalBalanceChart.all = tempMaxChartData
                self?.totalBalanceChart.threeMonth = tempThreeMonthChartData
                self?.totalBalanceChart.oneMonth = tempOneMonthChartData
                self?.totalBalanceChart.oneWeek = tempOneWeekChartData
                self?.isTotalBalanceChartDataLoaded = true
            }
            
        } catch {
            print("Error fetching data for address \(lowerCaseAddress): \(error)")
        }
    }
    
    
    
    
}


