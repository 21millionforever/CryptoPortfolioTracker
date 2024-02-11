//
//  SharedDataModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/23/24.
//

import Foundation

/// A model for shared data
///
/// This class is responsible for stroing data like wallet addresses.  When the model is initialized, it loads addresses from the cache to the class variable addresses automatically.  When addresses is updates, the value in cahce updates as well, no need for extra actions.
class SharedDataModel: ObservableObject {
    @Published var addresses: [String] = []
    {
 
        didSet {
            UserDefaults.standard.set(addresses, forKey: "addresses")
        }
    }
    
    init() {
        self.addresses = UserDefaults.standard.object(forKey: "addresses") as? [String] ?? []
    }
}
