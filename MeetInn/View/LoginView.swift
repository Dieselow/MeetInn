//
//  LoginView.swift
//  MeetInn
//
//  Created by Louis Dumont on 15/05/2021.
//

import SwiftUI
import Combine
import Foundation


struct LoginView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var viewModel = LoginViewModel()
    @State var isSubmit = false    
    
    
        // MARK: - View
        var body: some View {
            VStack() {
                Text("MeetInn Login")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], 40)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image("Logo")
                    .resizable(resizingMode: .tile)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, 50)
                
                VStack(alignment: .leading, spacing: 15) {
                    if viewModel.isLoading {
                        ProgressView().frame(maxWidth: .infinity, alignment: .center)
                    }
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    SecureField("Password", text: self.$password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {
                    LoginUserAction(email: email, password: password)
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 50)
                
                Spacer()
                HStack(spacing: 0) {
                    Text("Don't have an account? ")
                    Button(action: {self.isSubmit = true}) {
                        Text("Sign Up")
                            .foregroundColor(.black)
                    }.sheet(isPresented:$isSubmit , content: {
                        RegisterView()
                    })
                }
            }.fullScreenCover(isPresented: $viewModel.isLoggedIn, content: HomeView.init)

            .background(
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            
        }
    func LoginUserAction(email: String,password: String) -> Void {
        let user = UserLoginModel(email: email, password: password )
        viewModel.Login(user: user)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
