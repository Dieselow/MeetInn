//
//  ViewUtils.swift
//  MeetInn
//
//  Created by Louis Dumont on 20/07/2021.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
             self.hidden()
         } else {
            self
         }
     }
}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
