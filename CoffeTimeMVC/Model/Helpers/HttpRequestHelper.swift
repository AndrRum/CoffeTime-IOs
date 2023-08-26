//
//  HttpRequestHelper.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation

class HttpRequestHelper {
    typealias CompletionHandler = (Any?, Error?) -> Void
    
    private let baseUrl = "http://ci2.dextechnology.com:8000/api"
    
    func sendPostRequest(url: String, jsonData: [String: Any], completion: @escaping CompletionHandler) {
        guard let url = URL(string: baseUrl + url) else {
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
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("Status Code:", statusCode)
                    
                    if statusCode == 500 {
                                        
                        NotificationCenter.default.post(name:NSNotification.Name("HttpErrorStatus500"), object: nil)
                        return
                    }
                                               
                    if let data = data {
                        if let responseString = String(data: data, encoding: .utf8) {
                        print("Raw Response Data:", responseString)
                        completion(responseString, nil) // Return as a string
                    } else {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            completion(json, nil) // Return as JSON object
                        } catch {
                            print("JSON Parsing Error:", error)
                            completion(nil, error)
                        }
                    }
                }
            }
            
        }
            
        task.resume()
            
        } catch {
            completion(nil, error)
        }
    }
}

