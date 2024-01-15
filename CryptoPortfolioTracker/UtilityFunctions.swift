//
//  UtilityFunctions.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/8/24.
//

import Foundation

func CalculateTotalBalanceChart(walletToBalanceChart : [String: BalanceChartData], timeInteval: String) -> [[Double]]{
    // Step 1: Merge lists
    var mergedList = [[Double]]()
    for (address, balanceChartData) in walletToBalanceChart {
        if (timeInteval == "All") {
            mergedList += balanceChartData.all ?? []
        }
        else if (timeInteval == "7") {
            mergedList += balanceChartData.oneWeek ?? []
        }
        else if (timeInteval == "1") {
            mergedList += balanceChartData.oneDay ?? []
        }
        
        
//        if (timeInteval == "All") {
//            if let data = balanceChartData.all{
//                mergedList += data
//            }
//        }
    }
    
    // Step 2: Sum values using a dictionary
    var sumDict = [Double: Double]()
    
    for item in mergedList {
        let key = item[0]
        let value = item[1]

        sumDict[key, default: 0] += value
    }
    
    // Step 3: Convert dictionary back to array
    let combinedList = sumDict.map { [$0.key, $0.value] }
    
    // Sort by the first element if needed
    let sortedCombinedList = combinedList.sorted { $0[0] < $1[0] }
    return sortedCombinedList
}


func createRange(from: Double, to: Double) -> ClosedRange<Int> {
    let startValue = Int(from)
    let endValue = Int(to)
    let range = startValue...endValue
    
    return range
}
