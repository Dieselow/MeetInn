//
//  LoginViewModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/06/2021.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    //@Published private(set) var user: UserDataModel?
    @Published private(set) var user: UserModel? 
    @Published private(set) var isLoading = false
    @Published var isLoggedIn = false
    private var request: UserLoginRequest?
    let defaults = UserDefaults.standard
    func Login(user: UserLoginModel, completion: @escaping (Bool) -> Void) {
        let params = ["email": user.email, "password": user.password] as Dictionary<String, String>

        guard !isLoading else { return }
                isLoading = true
        

        let resource = UserLoginResource(body: params)
        let request = UserLoginRequest(request: resource.request)
        self.request = request
        request.execute { [weak self] user in
            self?.user = user ?? nil
            self?.isLoading = false
            if (user != nil) {
                self?.isLoggedIn = true
                completion(true)
                if let data  = try? JSONEncoder().encode(user) {
                    self?.defaults.set(data,forKey: "currentUser");
                }
            
            }
        }
        
    }
}
