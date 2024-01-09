//
//  UtilityFunctions.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/8/24.
//

import Foundation

func getHistoricalTotalValueChart(walletsBalanceChart : [String: [[Double]]]) -> [[Double]]{
    // Step 1: Merge lists
    var mergedList = [[Double]]()
    for (address, chart) in walletsBalanceChart {
        mergedList += chart
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
    print(sortedCombinedList)
    return sortedCombinedList
}
