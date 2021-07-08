//
//  RegisterView.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/06/2021.
//

import SwiftUI

struct RegisterView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var dob = Date()
    @ObservedObject var viewModel = RegisterViewModel()
    @ObservedObject var loginViewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack() {
            Text("MeetInn Register")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
                .shadow(radius: 10.0, x: 20, y: 10)
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: self.$email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Firstname", text: self.$firstname)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Lastname", text: self.$lastname)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                SecureField("Confirm Password", text: self.$confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
               DatePicker("Birthday", selection: $dob)
                .frame(maxHeight: 20)
                .foregroundColor(Color.gray)
                .padding()
                .background(Color.white)
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            }.padding([.leading, .trailing], 27.5)
            Button(action: {RegisterUserAction(email: email, password: password, confirmPassword: confirmPassword, firstname: firstname, lastname: lastname, bitrhDate: dob)}) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            
            Spacer()
        }.background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
    func RegisterUserAction(email: String,password: String,confirmPassword: String, firstname: String, lastname: String, bitrhDate: Date) -> Void {

        viewModel.registerUser(newUser: UserRegisterModel(email: email, firstname: firstname, lastname: lastname, password: password, confirmPassword: confirmPassword, birthDate: bitrhDate), completion: {
            result in
            if result {
                loginViewModel.Login(user: UserLoginModel(email: email, password: password)) { isLoggedIn in
                    if isLoggedIn {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
