//
//  Date.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/28/24.
//

import Foundation

extension Date {
    func asMediumDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
