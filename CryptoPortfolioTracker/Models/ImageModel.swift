//
//  ImageModel.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/24/24.
//

import Foundation
import SwiftUI




class ImageModel: ObservableObject {
    
    static let shared = ImageModel()

    private init() {}

    private var cache = NSCache<NSString, UIImage>()

    func getImage(forKey key: String) -> UIImage? {
        
        return cache.object(forKey: NSString(string: key))
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    
    
//    func fetchTokenImageUrls(tokenSymbol: String) async throws -> TokenImage {
//
//        let endpoint = "\(Config.server_url)/getTokenImage/\(tokenSymbol)"
//
//        guard let url = URL(string: endpoint) else {
//            throw APIError.invalidURL
//        }
//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw APIError.invalidResponse
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let response = try decoder.decode(TokenImage.self, from: data)
//            return response
//        } catch {
//            throw APIError.invalidData
//        }
//    }
    
//    func loadTokenImageUrls()
    
    

    
    
}
