//
//  RegisterViewModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/06/2021.
//

import Foundation
class RegisterViewModel: ObservableObject {
    @Published private(set) var user: UserRegisteredModel?
    @Published private(set) var isLoading = false
    private var request: UserRegistrationRequest?
    
    func registerUser(newUser: UserRegisterModel){
        guard !isLoading else { return }
                isLoading = true
        
    
        let params = ["email": newUser.email, "password": newUser.password, "firstname": newUser.firstname,
                      "lastname": newUser.lastname] as Dictionary<String, String>
        let resource = UserRegistrationResource(body: params)
        let request = UserRegistrationRequest(request: resource.request)
        self.request = request
        request.execute { [weak self] user in
                    self?.user = user ?? nil
                    self?.isLoading = false
                }
    }
}
