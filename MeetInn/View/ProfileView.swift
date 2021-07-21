//
//  ProfileView.swift
//  MeetInn
//
//  Created by Louis Dumont on 21/07/2021.
//

import SwiftUI

struct ProfileView: View {
    var profile: UserModel?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text(profile!.email).font(.title).bold().padding()
                List {
                    NavigationLink(
                        destination: UserReservationView()){
                        Text("See your reservations")
                    }
                }
            }.navigationTitle("Your profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
