//
//  TimeslotView.swift
//  MeetInn
//
//  Created by Louis Dumont on 09/07/2021.
//

import SwiftUI

struct TimeslotView: View {
    var timeslotDate: TimeslotDate
    @ObservedObject var viewModel = ReservationViewModel()
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var selectedTimeSlot: Timeslot?
    @State private var showDetail = false
    var body: some View {
        Button(action: {
            withAnimation {
                self.showDetail.toggle()
            }
        }) {
            HStack {
                Text("\(timeslotDate.dayName), \(timeslotDate.dayNumber) \(timeslotDate.month) \(timeslotDate.year)")
                Image(systemName: "chevron.right.circle")
                    .imageScale(.large)
                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                    .scaleEffect(showDetail ? 1.5 : 1)
                    .padding()
            }
            
        }
        
        if showDetail {
            LazyVGrid(columns: threeColumnGrid, spacing: 30) {
                //Display the item
                ForEach((0...timeslotDate.timeslots.count - 1), id: \.self) {
                    let timeslot = timeslotDate.timeslots[$0 % timeslotDate.timeslots.count]
                    let startDate = viewModel.convertDate(timestamp: timeslot.startDate)
                    let endDate = viewModel.convertDate(timestamp: timeslot.endDate)
                    let isSelected = timeslot.id == $selectedTimeSlot.wrappedValue?.id
                    ZStack{
                        if timeslot.reservation == nil {
                            RoundedRectangle(cornerRadius: 4).stroke().background(isSelected ? Color.blue : Color.white).frame(width: 120, height: 50).onTapGesture {
                                selectedTimeSlot = timeslot
                            }
                            Text("\(startDate) - \(endDate)").padding().foregroundColor(isSelected ? Color.white : Color.blue)
                        }
                        else {
                            RoundedRectangle(cornerRadius: 4).stroke().background(Color.gray).frame(width: 120, height: 50)
                            Text("\(startDate) - \(endDate)").padding().foregroundColor(Color.white)
                        }
                    }.transition(.slide)
                }
            }
        }
        
    }
}

//struct TimeslotView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeslotView()
//    }
//}
