//
//  PartnerDetail.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import SwiftUI
import MapKit

struct PartnerDetail: View {
    var partner: PartnerModel
    @State var isGuest = false
    @State var shouldRedirectToLogin = false
    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2D(latitude: partner.address?.latitude ?? 34.011_286, longitude: partner.address?.longitude ?? -116.166_868))
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            VStack(alignment: .leading) {
                Text(partner.name)
                    .font(.title)
                    .foregroundColor(.primary)

                HStack {
                    Text(partner.address?.name ?? "Cupertino")
                    Spacer()
                    Text(partner.address?.region ?? "California")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(partner.name)")
                    .font(.title2)
                Text(partner.phoneNumber)
                
                Spacer()
                
                Button("Reserve", action: {
                    let user = UserDefaults.standard.object(forKey: "currentUser")
                    if user == nil {
                        isGuest.toggle();
                    }
                }).alert(isPresented: $isGuest){
                    Alert(
                        title: Text("Attention"),
                        message: Text("To make a reservation, you need to log in"),
                        dismissButton: Alert.Button.default(
                            Text("Press ok here"), action: { shouldRedirectToLogin.toggle() }
                        )
                    )
                }.sheet(isPresented:$shouldRedirectToLogin , content: {
                    LoginView()
                })
            }
            .padding()

            Spacer()
        }
    }
}


struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}


struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    @State private var markers: [Marker] = []


    var body: some View {
        Map(coordinateRegion: $region,showsUserLocation: false,  annotationItems: markers){
            marker in marker.location
        }.onAppear {
            markers = ([Marker(location: MapMarker(coordinate: self.coordinate, tint: .red))])
            setRegion(self.coordinate)
        }
    }
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
           region = MKCoordinateRegion(
               center: coordinate,
               span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
           )
       }
}
