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
    @State private var image: UIImage? = nil
    @State var isGuest = false
    @State var shouldRedirectToLogin = false
    @State var isConnected = false
    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2D(latitude: partner.address?.latitude ?? 34.011_286, longitude: partner.address?.longitude ?? -116.166_868))
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            if image != nil {
                CircleImage(image: image!)
                    .offset(y: -200)
                //.padding(.bottom, -250)
            }
            else {
                ProgressView().frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
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
            }
            .padding(.top,-220)
            VStack{
                HStack{
                    Button(action: {
                        let user = UserDefaults.standard.object(forKey: "currentUser")
                        if user == nil {
                            isGuest = true;
                        }
                        else {
                            isConnected = true
                        }
                    }){
                        HStack {
                            Image(systemName: "bookmark")
                                .font(.title)
                            Text("Reserve")
                                .fontWeight(.semibold)
                                .font(.body)
                        }
                    }.padding().foregroundColor(.white).background(Color.blue).cornerRadius(40)
                    .alert(isPresented: $isGuest){
                        Alert(
                            title: Text("Attention"),
                            message: Text("To make a reservation, you need to log in"),
                            dismissButton: Alert.Button.default(
                                Text("Press ok here"), action: { shouldRedirectToLogin.toggle() }
                            )
                        )
                    }.sheet(isPresented:$shouldRedirectToLogin ,onDismiss: {
                        if  UserDefaults.standard.object(forKey: "currentUser") != nil{
                            isConnected.toggle()
                        }
                    }, content: {
                        LoginView()                    
                    }).sheet(isPresented:$isConnected , content: {
                        ReservationView(partner: partner)
                    })
                }
            }.padding(.top,-100)
        }.onAppear{
            setImage(from: partner.photoUrl)
        }
    }
    
    func setImage(from url: String?) {
        guard let imageURL = URL(string: url ?? "https://shorturl.at/psuP8") else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                if image != nil {
                    self.image = image!
                }
            }
        }
    }
}


struct CircleImage: View {
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
            .frame(width: 250)
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


struct PartnerDefailt_Previews: PreviewProvider {
    static var previews: some View {
        let mockAddress = AddressModel(latitude: 48.370441, longitude: 2.816867, type: "address", name: "6 Rue De Madame", number: "", postalCode: "", street: "", confidence: 1.0, region: "Ile de france", regionCode: "IDF", county: "", locality: "", administrativeArea: "", neighborhood: "", country: "France", countryCode: "FR", continent: "Europe", label: "oui")
        PartnerDetail(partner: PartnerModel(id: "", name: "L'esco-bar", phoneNumber: "+33610973240", address: mockAddress, createDate:  "Jul 6, 2021, 12:06:00 PM", timeSlots: [], photoUrl: "https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80"))
    }
}
