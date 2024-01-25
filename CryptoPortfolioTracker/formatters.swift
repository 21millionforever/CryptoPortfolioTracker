//
//  formatters.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/5/24.
//

//import Foundation



//func formatAsCurrency(number: Double?) -> String {
//    guard let number = number else {
//        return "Unknown"
//    }
//
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .currency
//    formatter.locale = Locale(identifier: "en_US") // Adjust the locale to your target audience
//    formatter.maximumFractionDigits = 2
//    formatter.minimumFractionDigits = 2
//
//    // Safely unwrap the optional returned by the formatter
//    if let formattedString = formatter.string(from: NSNumber(value: number)) {
//        return formattedString
//    } else {
//        return "Formatting Error"
//    }
//}


//func getPricePercentageDiff(data : [[Double]]?, currentBalance: Double?) -> String {
//    guard let data = data else {
//        return "chart data doesn't exist"
//    }
//    guard let currentBalance = currentBalance else {
//        return "current balance doesn't exist"
//    }
//    // If the data exist
//    let diffPer = (currentBalance - data[0][1]) / currentBalance
//    print("Percentage")
//    print(diffPer)
//
//    return formatAsPercentage(number: diffPer)
//
//
//}
//
//func formatAsPercentage(number: Double) -> String {
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .percent
//    formatter.maximumFractionDigits = 2  // Set the number of decimal places
//    formatter.minimumFractionDigits = 2
//
//    // Note: Multiplying by 100 because the input is a decimal, not a percentage
//    return formatter.string(from: NSNumber(value: number)) ?? "N/A"
//}


// 12345.6789 to 12,345.679
//func formatNumber(_ number: Double?) -> String {
//    guard let number = number else {
//        return "-1" // Default value if number is nil
//    }
//
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .decimal
//    formatter.maximumFractionDigits = 2
//    formatter.minimumFractionDigits = 2
//
//    return formatter.string(from: NSNumber(value: number)) ?? ""
//}


// TODO: get rid of these formatters
