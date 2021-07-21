//
//  UserReservationView.swift
//  MeetInn
//
//  Created by Louis Dumont on 21/07/2021.
//

import SwiftUI

struct UserReservationView: View {
    @ObservedObject var viewModel = ReservationViewModel()
    var body: some View {
        ScrollView{
            ZStack {
                if viewModel.userReservations.count > 0 {
                    ForEach((0...viewModel.userReservations.capacity), id: \.self) {
                        let reservation = viewModel.userReservations[$0 % viewModel.userReservations.count]
                        ZStack{
                            RoundedRectangle(cornerRadius: 4).stroke().background(Color.white).frame(width: UIScreen.screenWidth, height: 50)
                            Text("\(viewModel.getTimeStampLongDate(timeStamp: reservation.startDate)) - \(viewModel.getTimeStampLongDate(timeStamp: reservation.endDate))")
                        }.padding()
                    }
                    if self.viewModel.isLoading {
                        ProgressView().frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                else {
                    Text("You don't have any reservations")
                }
            }.navigationTitle("Your reservations")
        }.onAppear(perform: self.fetchUserReservations)
    }
    
    private func fetchUserReservations()-> Void {
        viewModel.getUsersReservation()
    }
    
}

struct UserReservationView_Previews: PreviewProvider {
    static var previews: some View {
        UserReservationView()
    }
}
