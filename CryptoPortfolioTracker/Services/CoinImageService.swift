//
//  CoinImageService.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/25/24.
//

import Foundation
import SwiftUI


class CoinImageService {
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    
    func getCoinImage(imageName: String, urlString: String) async throws -> UIImage? {
        if let image = fileManager.getImage(imageName: imageName, folderName: folderName) {
            print("Retrieved image from File Manager")
            return image
        }
        else {
            do {
                let image = try await fetchCoinImage(imageName: imageName, urlString: urlString)
                return image
            } catch let error {
                print("Error fetching coin image. \(error)")
                return nil
            }
        }
    }
        
    func fetchCoinImage(imageName: String, urlString: String) async throws -> UIImage {
        print("Downloading image now")
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw APIError.invalidData
        }
        
        fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
        
        return image
    }
        
        
    
}
