import Foundation

class HttpRequestHelper {
    typealias CompletionHandler = (Any?, Error?) -> Void
    
    private let baseUrl = "http://cafe.prox2.dex-it.ru/api"
    
    func sendPostRequest(url: String, jsonData: [String: Any]?, withSid: Bool, completion: @escaping CompletionHandler) {
        let urlString = baseUrl + url
        var requestData: Any?
        
        if withSid {
            fetchSessionId { sessionId in
                if let sessionId = sessionId {
                    if var modifiedJsonData = jsonData {
                        modifiedJsonData["sessionId"] = sessionId
                        requestData = self.transformRequestData(modifiedJsonData)
                    } else {
                        requestData = sessionId
                    }
                    
                    self.performPostRequest(urlString: urlString, requestData: requestData, completion: completion)
                }
            }
        } else {
            requestData = jsonData
            self.performPostRequest(urlString: urlString, requestData: requestData, completion: completion)
        }
    }
}

//MARK: Request handlers
extension HttpRequestHelper {
    private func fetchSessionId(completion: @escaping (String?) -> Void) {
        let userDataService = UserDataService()
        userDataService.fetchSid { sessionId in
            completion(sessionId)
        }
    }
    
    private func transformRequestData(_ data: [String: Any]) -> Any {
        let transformedRequest = data.compactMapValues { value in
            (value as AnyObject).replacingOccurrences(of: "\"", with: "")
        }
        return transformedRequest
    }
    
    
    private func performPostRequest(urlString: String, requestData: Any?, completion: @escaping CompletionHandler) {
        guard let url = URL(string: urlString) else {
            handleError(error: NSError(domain: "Invalid URL", code: -1, userInfo: nil), completion: completion)
            return
        }
        
        do {
            let request = try buildPostRequest(url: url, requestData: requestData)
            print("Request URL: \(urlString)")
            
            sendRequest(request, completion: completion)
            
        } catch {
            print("Error performing POST request:", error)
            completion(nil, error)
        }
    }
    
    private func handleError(error: Error, completion: @escaping CompletionHandler) {
        if error.localizedDescription.range(of: "timed out") != nil {
            NotificationManager.shared.postNotification(name: "HttpErrorStatus500")
        }
        print("Error: \(error.localizedDescription)")
        completion(nil, error)
    }
    
    
    private func buildPostRequest(url: URL, requestData: Any?) throws -> URLRequest {
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
        
        return request
    }
    
    private func sendRequest(_ request: URLRequest, completion: @escaping CompletionHandler) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            self.handleDataTaskCompletion(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
}

//MARK: Response handlers
extension HttpRequestHelper {
    private func handleDataTaskCompletion(data: Data?, response: URLResponse?, error: Error?, completion: @escaping CompletionHandler) {
        if let error = error as NSError?, error.code == NSURLErrorTimedOut {
            errorHandler(error: error, completion: completion)
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            responseHandler(httpResponse: httpResponse, data: data, completion: completion)
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
        
        guard (200..<300).contains(statusCode) else {
            handleNon200StatusCode(statusCode: statusCode, completion: completion)
            return
        }
        
        guard let data = data else {
            completion(nil, NSError(domain: "NoDataError", code: -1, userInfo: nil))
            return
        }
        
        do {
            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString, nil)
            } else {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                completion(json, nil)
            }
        } catch {
            print("Error parsing response:", error)
            completion(nil, error)
        }
    }
    
    private func handleNon200StatusCode(statusCode: Int, completion: @escaping CompletionHandler) {
        NotificationManager.shared.postNotification(name: "HttpErrorStatus500")
        
        let error = NSError(domain: "HTTPErrorDomain", code: statusCode, userInfo: nil)
        print("HTTP Error: \(statusCode)")
        completion(nil, error)
    }
}
