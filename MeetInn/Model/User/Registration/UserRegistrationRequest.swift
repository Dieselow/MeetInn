//
//  UserRegistrationRequest.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation
class UserRegistrationRequest {
    let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
}
 
extension UserRegistrationRequest: NetworkRequest {
    typealias ModelType = UserRegisteredModel
    
    func decode(_ data: Data) -> ModelType? {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            print(data)
            do {
                let wrapper = try decoder.decode(ModelType.self, from: data)
                return wrapper

            } catch  {
                print(error)
            }
            return nil
        }
    
    func execute(withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,Error?) -> Void) {
        load(request, withCompletion: completion)
    }
}
