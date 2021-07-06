//
//  Exceptions.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import Foundation

struct LoginError : Error {
    let message: String

   init(_ message: String)
   {
       self.message = message
   }

   public var errorDescription: String?
   {
       return message
   }
}
