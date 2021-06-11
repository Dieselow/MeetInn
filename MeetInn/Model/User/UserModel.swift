//
//  UserModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation
struct UserModel {
    //let Id : String
    let email: String
    let createdAt: Date
    let expiresAt: Date
    let roles: [Roles]?
}

extension UserModel: Decodable {
    enum CodingKeys: String, CodingKey {
        //case Id = "id"
        case createdAt = "iat"
        case email = "sub"
        case roles = "roles"
        case expiresAt = "exp"
    }
}
