//
//  UserLoginModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/06/2021.
//

import Foundation
struct UserLoginModel {
    public var email: String
    public var password: String
    
    init(email:String, password: String) {
        self.email = email;
        self.password = password
    }
}
