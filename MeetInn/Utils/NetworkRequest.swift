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
    func execute(withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,Error?) -> Void)
}

extension NetworkRequest {
    func load(_ url: URLRequest, withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data: Data?, resp: URLResponse? , err:Error?) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil, nil, err) }
                return
            }
            DispatchQueue.main.async { completion(value, resp as? HTTPURLResponse, nil) }
        }
        task.resume()
    }
}
