//
//  UserLoginRequest.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation
import JWTDecode
class UserLoginRequest {
    let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
}
 
extension UserLoginRequest: NetworkRequest {
    typealias ModelType = UserModel
    
    func decode(_ data: Data) -> ModelType? {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
        var roles : [Roles] = []
            print(data)
            do {
                let wrapper = try decoder.decode(JWTTokenModel.self, from: data)
                let jwt = try JWTDecode.decode(jwt: wrapper.token!)
                let jwtRoles: [Dictionary<String,String>] = jwt.claim(name: "roles").rawValue as! [Dictionary<String,String>]
                jwtRoles.forEach{ jwtRole in
                    roles.append(Roles(Id: jwtRole["id"], role: jwtRole["role"]))
                }
                //
                
                return UserModel(email: jwt.subject!, createdAt: jwt.issuedAt!, expiresAt: jwt.expiresAt!, roles: roles )

            } catch  {
                print(error)
            }
            return nil
        }
    
    func execute(withCompletion completion: @escaping (ModelType?) -> Void) {
        load(request, withCompletion: completion)
    }
}
