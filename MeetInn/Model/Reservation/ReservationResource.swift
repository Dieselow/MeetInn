//
//  ReservationResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 08/07/2021.
//

import Foundation
struct ReservationResource: APIResource {
    var body: Dictionary<String, String>?
    
    typealias ModelType = Timeslot
    
    var httpMethod: String {
        return "POST"
    }
    
    var id: String?
    var token: String?
    
    var methodPath: String {
        return "/timeslots/" + self.id! + "/reservation"
    }
    
    var filter: String? {
        return nil
    }
}
