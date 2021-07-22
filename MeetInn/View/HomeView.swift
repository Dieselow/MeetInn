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
    @State var user : UserModel? = nil
    
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
                if(user != nil) {
                    Button(action: { showingProfile.toggle() }) {
                        Image(systemName: "person.crop.circle")
                            .accessibilityLabel("User Profile")
                    }
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileView(profile: self.user)
            }
            
        }.onAppear(perform: fetchPartners).onAppear(perform: getUser)
        
    }
    
    private func getUser() -> Void{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let userData = UserDefaults.standard.object(forKey: "currentUser")
        if userData != nil {
            do {
                user =  try decoder.decode(UserModel.self, from: userData as! Data)
            }
            catch  {
                print(error)
            }
        }
        
        return
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
