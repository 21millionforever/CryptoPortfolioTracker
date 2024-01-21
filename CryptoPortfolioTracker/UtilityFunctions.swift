//
//  UtilityFunctions.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/8/24.
//

import Foundation

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




//func CalculateTotalBalanceChart(walletToBalanceChart : [String: BalanceChartData], timeInterval: String) -> [[Double]] {
//    // Step 1: Merge lists
//    var mergedList = [DataPoint]()
//    for (_, balanceChartData) in walletToBalanceChart {
//        if timeInterval == "All" {
//            mergedList += balanceChartData.all ?? []
//        } else if timeInterval == "7" {
//            mergedList += balanceChartData.oneWeek ?? []
//        } else if timeInterval == "1" {
//            mergedList += balanceChartData.oneDay ?? []
//        }
//    }
//
//    // Step 2: Sum values using a dictionary
//    var sumDict = [String: Double]()
//
//    for dataPoint in mergedList {
//        let date = dataPoint.date
//        let value = dataPoint.value
//
//        sumDict[date, default: 0] += value
//    }
//
//    // Step 3: Convert dictionary back to array
//    var combinedList = [[Double]]()
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MMMM d, yyyy" // adjust this format to match your date strings
//
//    for (dateString, value) in sumDict {
//        if let date = dateFormatter.date(from: dateString) {
//            combinedList.append([date.timeIntervalSince1970, value])
//        }
//    }
//
//    // Sort by the first element (timestamp)
//    let sortedCombinedList = combinedList.sorted { $0[0] < $1[0] }
//    return sortedCombinedList
//}

