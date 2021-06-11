//
//  UserLoginResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation

struct UserLoginResource: APIResource {
    typealias ModelType = UserModel
    
    var httpMethod: String {
        return "POST"
    }
    
    var body: Dictionary<String, String>?
    var id: Int?
    
    var methodPath: String {
        return "/auth/login"
    }
    
    var filter: String? {
        return nil
    }
    
    init(body: Dictionary<String,String>) {
        self.body = body;
    }
}
