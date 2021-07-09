//
//  TimeslotResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 09/07/2021.
//

import Foundation
struct TimeslotResource: APIResource {
    var token: String?
    
    var body: Dictionary<String, String>?
    
    typealias ModelType = Array<Timeslot>
    
    var httpMethod: String {
        return "GET"
    }
    
    var id: String?
    
    var methodPath: String {
        return "/partner/" + self.id! + "/timeslots"
    }
    
    var filter: String? {
        return nil
    }
}
