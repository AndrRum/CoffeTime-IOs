//
//  LoadImageManager.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 07.11.2023.
//

import Foundation
import UIKit

class LoadCafeImageManager {
    
    static func loadImage(for cafe: CafeModel?, placeholder: String, completion: @escaping (String) -> Void) {
        guard let imageName = cafe?.images, !imageName.isEmpty else {
            completion(placeholder)
            return
        }

        if imageName.lowercased().contains("http"), let imageUrl = URL(string: imageName) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if data != nil {
                    DispatchQueue.main.async {
                        completion(imageName)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(placeholder)
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                completion(imageName)
            }
        }
    }
}

