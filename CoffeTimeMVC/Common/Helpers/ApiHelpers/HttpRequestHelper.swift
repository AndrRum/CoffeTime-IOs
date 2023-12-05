import Foundation

class HttpRequestHelper {
    typealias CompletionHandler = (Any?, Error?) -> Void
    
    private let baseUrl = "http://cafe.prox2.dex-it.ru/api"
    
    func sendPostRequest(url: String, jsonData: [String: Any]?, withSid: Bool, completion: @escaping CompletionHandler) {
        let urlString = baseUrl + url
        var requestData: Any?

        if withSid {
            let userDataService = UserDataService()
            userDataService.fetchSid { sessionId in
                if let sessionId = sessionId {

                    if var modifiedJsonData = jsonData {
                        modifiedJsonData["sessionId"] = sessionId

                        let transformedRequest = modifiedJsonData.compactMapValues { value in
                            (value as AnyObject).replacingOccurrences(of: "\"", with: "")
                        }

                        requestData = transformedRequest
                        print("request", requestData as Any)
                    } else {
                        requestData = sessionId
                    }

                    self.performPostRequest(urlString: urlString, requestData: requestData, completion: completion)
                }
            }
        } else {
            // Если не требуется sessionId, просто отправляем запрос с jsonData
            requestData = jsonData
            self.performPostRequest(urlString: urlString, requestData: requestData, completion: completion)
        }
    }

    private func performPostRequest(urlString: String, requestData: Any?, completion: @escaping CompletionHandler) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.timeoutInterval = 20.0

            if let jsonData = requestData as? [String: Any] {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                print("jsonData", jsonData)
                request.httpBody = jsonData
            } else if let stringData = requestData as? String {
                if let data = stringData.data(using: .utf8) {
                    request.httpBody = data
                }
            }
            
            print("Request URL: \(urlString)")


            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error as NSError?, error.code == NSURLErrorTimedOut {
                    self.errorHandler(error: error, completion: completion)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    self.responseHandler(httpResponse: httpResponse, data: data, completion: completion)
                }
            }
            
            task.resume()
            
        } catch {
            print("Error performing POST request:", error)
            completion(nil, error)
        }
    }

    private func errorHandler(error: Error, completion: @escaping CompletionHandler) {
        if error.localizedDescription.range(of: "timed out") != nil {
            NotificationManager.shared.postNotification(name: "HttpErrorStatus500")
        }
        print("Error: \(error.localizedDescription)")
        completion(nil, error)
    }
    
    private func responseHandler(httpResponse: HTTPURLResponse, data: Data?, completion: @escaping CompletionHandler) {
        let statusCode = httpResponse.statusCode
        print("Status Code:", statusCode)
        
        if statusCode == 100 || statusCode == 500 {
            NotificationManager.shared.postNotification(name: "HttpErrorStatus500")
        }
        
        if let data = data {
            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString, nil)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(json, nil)
                } catch {
                    print("JSON Parsing Error:", error)
                    completion(nil, error)
                }
            }
        }
    }
}
