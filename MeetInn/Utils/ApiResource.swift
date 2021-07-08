//
//  ApiResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var filter: String? { get }
    var httpMethod: String {get}
    var body: Dictionary<String,String>? {get set}
    var token: String? {get set}
}
 
extension APIResource {
    var url: URL {
        var components = URLComponents(string: "http://localhost:3001/api/v1")!
        components.path += methodPath
        components.queryItems = []
        if let filter = filter {
            components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
        }
        return components.url!
    }

    
    var request: URLRequest {
        var request =  URLRequest(url: url)
        request.httpMethod = httpMethod
        if token != nil {
            request.addValue(token!, forHTTPHeaderField: "BearerToken")
        }
        switch httpMethod {
        case "POST":
            request.httpBody = try? JSONSerialization.data(withJSONObject: body!, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        break;
        default:
            break;
        }
        
        return request
    }
}
