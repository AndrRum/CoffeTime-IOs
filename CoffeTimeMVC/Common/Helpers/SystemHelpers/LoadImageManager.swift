//
//  LoadImageManager.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 07.11.2023.
//

import Foundation
import UIKit

class LoadImageManager {
    static func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ImageLoadingError.invalidData))
                return
            }

            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }

    static func loadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let url = URL(string: urlString) {
            loadImage(from: url, completion: completion)
        } else {
            completion(.failure(ImageLoadingError.invalidURL))
        }
    }
}

enum ImageLoadingError: Error {
    case invalidData
    case invalidURL
}


