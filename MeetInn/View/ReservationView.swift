//
//  ReservationView.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/07/2021.
//

import SwiftUI

struct ReservationView: View {
    var partner: PartnerModel
    var fourColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var selectedTimeSlot: String? = nil
    var viewModel = ReservationViewModel()
    
    var body: some View {
        if partner.timeSlots?.count ?? 0 > 0 {
            VStack(spacing: 10) {
                HStack{
                    Text("Select your time slot").font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }.padding(.bottom,30)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: fourColumnGrid, spacing: 20) {
                        // Display the item
                        ForEach((0...partner.timeSlots!.count - 1), id: \.self) {
                            let timeslot = partner.timeSlots![$0 % partner.timeSlots!.count]
                            let startDate = viewModel.convertDate(timestamp: timeslot.startDate)
                            let endDate = viewModel.convertDate(timestamp: timeslot.endDate)
                            let isSelected = timeslot.id == $selectedTimeSlot.wrappedValue
                            ZStack{
                                RoundedRectangle(cornerRadius: 4).stroke().background(isSelected ? Color.blue : Color.white).frame(width: 120, height: 50).onTapGesture {
                                    selectedTimeSlot = timeslot.id
                                }
                                Text("\(startDate) - \(endDate)").padding().foregroundColor(isSelected ? Color.white : Color.blue)
                            }
                        }
                    }
                }
                Button(action: {
                    print("Delete tapped!")
                }) {
                    HStack {
                        Image(systemName: "cart")
                            .font(.title)
                        Text("Make reservation ! ")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }
                Spacer()
            }.padding()
        }
        else {
            Text("No TimeSlots available")
        }
        
    }
}

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockTimeSlots = [Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3),Timeslot(id: "", startDate: 1629454382, endDate: 1629484682, seats: 3)]
        let mockAddress = AddressModel(latitude: 48.370441, longitude: 2.816867, type: "address", name: "6 Rue De Madame", number: "", postalCode: "", street: "", confidence: 1.0, region: "Ile de france", regionCode: "IDF", county: "", locality: "", administrativeArea: "", neighborhood: "", country: "France", countryCode: "FR", continent: "Europe", label: "oui")
        ReservationView(partner: PartnerModel(id: "", name: "L'esco-bar", phoneNumber: "+33610973240", address: mockAddress, createDate:  "Jul 6, 2021, 12:06:00 PM", timeSlots: mockTimeSlots, photoUrl: "https://shorturl.at/psuP8"))
    }
}
