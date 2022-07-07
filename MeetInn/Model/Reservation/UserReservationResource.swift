//
//  UserReservationResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 21/07/2021.
//

import Foundation
struct UserReservationResource: APIResource {
    var body: Dictionary<String, String>?
    
    typealias ModelType = [Timeslot]
    
    var httpMethod: String {
        return "GET"
    }
    
    var id: String?
    var token: String?
    
    var methodPath: String {
        return "/timeslots/reservation/" + self.id!
    }
    
    var filter: String? {
        return nil
    }
}
