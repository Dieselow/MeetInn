//
//  PartnersViewModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import Foundation
class PartnersViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var partners: Array<PartnerModel> = []
    private var request: PartnerRequest?
    
    func getPartners() {
        guard !isLoading else { return }
        isLoading = true
        let resource = PartnerResource()
        let request = PartnerRequest(request: resource.request)
        self.request = request
        request.execute { [weak self] data in                    
            self?.isLoading = false
            if data != nil {
                self?.partners = data!
            }
                
        }
    }
}
