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
    
    

    
    
}
