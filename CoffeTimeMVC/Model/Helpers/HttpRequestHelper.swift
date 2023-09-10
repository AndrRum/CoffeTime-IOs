import Foundation

class HttpRequestHelper {
    typealias CompletionHandler = (Any?, Error?) -> Void
    
    private let baseUrl = "http://ci2.dextechnology.com:8000/api"
    
func sendPostRequest(url: String, jsonData: [String: Any], withSid: Bool, completion: @escaping CompletionHandler) {
        
        var urlString = baseUrl + url
        
        if withSid {
            let userDataService = UserDataService()
            userDataService.fetchSid { sessionId in
                urlString += "?sessionId=\(String(describing: sessionId))"
            }
        }
        
        guard let url = URL(string: urlString) else {
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
                    self.errorHandler(error: error, completion: completion)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    self.responseHandler(httpResponse: httpResponse, data: data, completion: completion)
                }
                
            }
            
            task.resume()
            
        } catch {
            completion(nil, error)
        }
    }
}

private extension HttpRequestHelper {
    func errorHandler(error: Error, completion: @escaping CompletionHandler) {
        if error.localizedDescription.range(of: "timed out") != nil {
            NotificationManager.shared.postNotification(name: "HttpErrorStatus500")
            return
        }
        completion(nil, error)
        return
    }
    
    func responseHandler(httpResponse: HTTPURLResponse, data: Data?, completion: @escaping CompletionHandler) {
        let statusCode = httpResponse.statusCode
        print("Status Code:", statusCode)
        
        if statusCode == 500 {
            NotificationManager.shared.postNotification(name: "HttpErrorStatus500")
            return
        }
        
        if let data = data {
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response Data:", responseString)
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
