//
//  ReservationView.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/07/2021.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
                 .combined(with: .opacity)
             let removal = AnyTransition.scale
                 .combined(with: .opacity)
             return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct ReservationView: View {
    @ObservedObject var viewModel = ReservationViewModel()
    var partner: PartnerModel
    @State var selectedTimeSlot: String? = nil
    @State var isReservationDone = false
    @State var timeSlotNotSelected = false
    @State var hasErrors = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            if viewModel.timeslots.count > 0 {
                VStack(spacing: 10) {
                    HStack{
                        Text("\(partner.name) Reservation").font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }.padding(.bottom,30)
                    Text("Choose your time").font(.footnote).foregroundColor(.gray).bold()
                    List {
                        ForEach((0...viewModel.timeslotsDates.count - 1), id:\.self){
                            let timeslotDate : TimeslotDate = viewModel.timeslotsDates[$0 % viewModel.timeslotsDates.count].value
                            TimeslotView(timeslotDate: timeslotDate, selectedTimeSlot: $selectedTimeSlot).transition(.moveAndFade)
                        }
                    }
                    Button(action: {
                        if selectedTimeSlot != nil {
                            self.makeReservation()
                        }
                        else {
                            timeSlotNotSelected.toggle()
                            hasErrors.toggle()
                        }
                    }){
                        HStack {
                            Image(systemName: isReservationDone ? "checkmark" : "cart")
                                .font(.title).rotationEffect(isReservationDone ? .degrees(360) : .degrees(0))
                            Text("Make reservation ! ")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(isReservationDone ? Color.green : Color.blue )
                        .animation(.easeIn, value: isReservationDone)
                        .cornerRadius(40)
                    }
                    .alert(isPresented: $hasErrors){
                        Alert(
                            title: Text("Attention"),
                            message: Text(timeSlotNotSelected ? "Please select an available timeslot before reserving" : "Something went wrong with your reservation, please try again in a few minutes "),
                            dismissButton: Alert.Button.default(
                                Text("Got it"), action: {hasErrors = false; timeSlotNotSelected = false}
                            )
                        )
                    }
                    Spacer()
                }.padding()
            }
            else {
                Text("No TimeSlots available")
            }
            if viewModel.isLoading {
                ProgressView().frame(maxWidth: .infinity, alignment: .center)
            }
        }.onAppear(perform: fetchTimeslots)
        
    }
    func makeReservation() -> Void {
        viewModel.createReservation(timeSlotId: self.selectedTimeSlot!, partnerId: self.partner.id){ isOk, errorMessage in
            if isOk {
                isReservationDone.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            else {
                hasErrors.toggle()
            }
            
        }
    }
    
    func fetchTimeslots(){
        viewModel.getTimeSlots(partnerId: self.partner.id)
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
