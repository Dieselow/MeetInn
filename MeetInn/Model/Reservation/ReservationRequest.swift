//
//  ReservationRequest.swift
//  MeetInn
//
//  Created by Louis Dumont on 08/07/2021.
//

import Foundation

class ReservationRequest{
    let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
}

extension ReservationRequest : NetworkRequest {
    typealias ModelType = [PartnerModel]
    
    func decode(_ data: Data) -> ModelType? {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            print(data)
            do {
                return try decoder.decode([PartnerModel].self, from: data)
            }
            catch  {
                print(error)
            }
            return nil
        }
    
    func execute(withCompletion completion: @escaping (ModelType?) -> Void) {
        load(request, withCompletion: completion)
    }
    
}
