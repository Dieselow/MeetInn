//
//  UserRegistrationResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation

struct UserRegistrationResource: APIResource {
    var httpMethod: String {
        return "POST"
    }
    
    var body: Dictionary<String, String>?
    typealias ModelType = UserRegisteredModel
    var id: Int?
    
    var methodPath: String {
        return "/auth/register"
    }
    
    var filter: String? {
        return nil
    }
    
    init(body: Dictionary<String,String>) {
        self.body = body;
    }
    
  
}
