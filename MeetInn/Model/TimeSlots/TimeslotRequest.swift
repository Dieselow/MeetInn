//
//  TimeslotRequest.swift
//  MeetInn
//
//  Created by Louis Dumont on 09/07/2021.
//

import Foundation
class TimeslotRequest {
    let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
}

extension TimeslotRequest: NetworkRequest {
    typealias ModelType = [Timeslot]
    
    func decode(_ data: Data) -> ModelType? {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            do {
                return try decoder.decode([Timeslot].self, from: data)
            }
            catch  {
                print(error)
            }
            return nil
        }
    
    func execute(withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,String?) -> Void) {
        load(request, withCompletion: completion)
    }
}
