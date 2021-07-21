//
//  HomeView.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = PartnersViewModel()
    @State var needRefresh: Bool = false
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.partners,id:\.id) { partner in
                    NavigationLink(destination: PartnerDetail(partner: partner)) {
                        PartnerRowView(partner: partner)
                    }
                }
                if self.viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity, alignment: .center)
                }
            }.navigationTitle("Partners")
            .toolbar {
                if( getUser() != nil) {
                    Button(action: { showingProfile.toggle() }) {
                        Image(systemName: "person.crop.circle")
                            .accessibilityLabel("User Profile")
                    }
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileView(profile: self.getUser()!)
            }
            
        }.onAppear(perform: fetchPartners)
        
    }
    private func getUser() -> UserModel?{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
        return try decoder.decode(UserModel.self, from: UserDefaults.standard.object(forKey: "currentUser") as! Data)
        }
        catch  {
            print(error)
        }
        return nil
    }
    
    private func fetchPartners() -> Void {
        viewModel.getPartners()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
