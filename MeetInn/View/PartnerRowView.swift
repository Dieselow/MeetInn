//
//  PartnerRowView.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import SwiftUI

struct PartnerRowView: View {
    let partner: PartnerModel
    var body: some View {
        HStack
        {
         Text(partner.name)
        }
    }
}
