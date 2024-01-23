//
//  SharedDataModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/23/24.
//

import Foundation

class SharedDataModel: ObservableObject {
    @Published var addresses: [String] = []
    {
        // The didSet observer on addresses saves the new value to UserDefaults whenever the addresses array changes.
        didSet {
            UserDefaults.standard.set(addresses, forKey: "addresses")
        }
    }
    
    init() {
        self.addresses = UserDefaults.standard.object(forKey: "addresses") as? [String] ?? []
    }
}
