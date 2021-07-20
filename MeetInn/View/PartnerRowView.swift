//
//  PartnerRowView.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import SwiftUI

struct PartnerRowView: View {
    let partner: PartnerModel
    @State private var image: UIImage? = nil
    var body: some View {
        HStack
        {
            if image != nil {
                Image(uiImage: self.image!).resizable()
                    .frame(width: 50, height: 50)
            }
            else {
                ProgressView().frame(maxWidth: 50, maxHeight: 50, alignment: .center)
            }
            Text(partner.name)
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
