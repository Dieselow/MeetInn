//
//  UserModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation
struct UserModel: Encodable {
    let Id : String
    let email: String
    let createdAt: Date
    let expiresAt: Date
    let roles: [Roles]?
    let token: String
}

extension UserModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case createdAt = "iat"
        case email = "sub"
        case roles = "roles"
        case expiresAt = "exp"
        case token = "token"
    }
}
