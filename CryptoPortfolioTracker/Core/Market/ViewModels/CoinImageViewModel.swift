//
//  CoinImageViewModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/26/24.
//

import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coinImageService = CoinImageService()
    
    init(coin: Coin){
        Task {
            await getImage(urlString: coin.image, imageName: coin.id)
        }
    }
    
    func getImage(urlString: String, imageName: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        do {
            let fetchedImage = try await coinImageService.getCoinImage(imageName: imageName, urlString: urlString)
            DispatchQueue.main.async {
                self.image = fetchedImage
                self.isLoading = false
            }
        } catch {
            print("Error fetching image: \(error)")
            DispatchQueue.main.async {
                self.isLoading = false
                // Handle error, such as setting a default image or an error flag
            }
        }
    }
}
