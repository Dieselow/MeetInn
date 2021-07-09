//
//  NetworkRequest.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,String?) -> Void)
}

extension NetworkRequest {
    func load(_ url: URLRequest, withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,String?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, resp: URLResponse? , err:Error?) -> Void in
            guard let data = data, let httpResponse = resp as? HTTPURLResponse, let value = self.decode(data) else {
                let errorMessage = self.handleError(httpResponse: resp as? HTTPURLResponse)
                DispatchQueue.main.async { completion(nil, resp as? HTTPURLResponse, errorMessage ) }
                return
            }
            DispatchQueue.main.async { completion(value, httpResponse, nil) }
        }
        task.resume()
    }
    
    func handleError(httpResponse: HTTPURLResponse?) -> String{
        var errorMessage: String
        switch httpResponse?.statusCode {
        case 500:
            errorMessage = "Something went wrong with the server, please try again in a few minutes"
            break
        case 403:
            errorMessage = "You do not have sufficient rights to access to this resource"
            break
        case 404:
            errorMessage = "Nothing Found"
            break
        default:
            errorMessage = "Something went wrong, please try again"
            break
        }
        return errorMessage
    }
}
