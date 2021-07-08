//
//  ApiRequest.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation
struct Wrapper<T: Decodable>: Decodable {
    let items: [T]
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}
 
extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let wrapper = try decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
            return wrapper.items

        } catch  {
            print(error)
            return nil
        }
    }
    
    func execute(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
        load(resource.request, withCompletion: completion)
    }
}
