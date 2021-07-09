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
                let token = wrapper.token ?? nil
                if token == nil {
                    throw LoginError("No user found")
                }
                let jwt = try JWTDecode.decode(jwt: token!)
                let jwtRoles: [Dictionary<String,String>] = jwt.claim(name: "roles").rawValue as! [Dictionary<String,String>]
                jwtRoles.forEach{ jwtRole in
                    roles.append(Roles(Id: jwtRole["id"], role: jwtRole["role"]))
                }
                //
                
                return UserModel(Id: jwt.claim(name: "id").string! ,email: jwt.claim(name: "sub").string!, createdAt: jwt.issuedAt!, expiresAt: jwt.expiresAt!, roles: roles, token: token! )

            }
            catch  {
                print(error)
            }
            return nil
        }
    
    func execute(withCompletion completion: @escaping (ModelType?,HTTPURLResponse?,String?) -> Void) {
        load(request, withCompletion: completion)
    }
}
