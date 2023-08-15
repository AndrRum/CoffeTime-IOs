//
//  HttpRequestHelper.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation

class HttpRequestHelper {
    typealias CompletionHandler = ([String: Any]?, Error?) -> Void
    
    func sendPostRequest(url: String, jsonData: [String: Any], completion: @escaping CompletionHandler) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(json, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
            
            task.resume()
        } catch {
            completion(nil, error)
        }
    }
}

