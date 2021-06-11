//
//  UserRegisterModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/06/2021.
//

import Foundation
struct UserRegisterModel : Decodable & Encodable{
    public var email: String
    public var firstname: String
    public var lastname: String
    public var password: String
    public var confirmPassword: String
    public var birthDate: Date
    
    init(email: String, firstname: String, lastname: String, password: String, confirmPassword: String, birthDate: Date) {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.confirmPassword = confirmPassword
        self.birthDate = birthDate
    }
}
