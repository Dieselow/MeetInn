//
//  HomeView.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = PartnersViewModel()

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
        }.onAppear(perform: fetchPartners)
    }
    private func fetchPartners() -> Void {
        viewModel.getPartners()
    }
}
extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
             self.hidden()
         } else {
            self
         }
     }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
