//
//  GSError.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 18.11.21.
//

import Foundation

enum GSError: String, Error {
    
    case invalidQuery       = "This query formed wrong URL request."
    case unableToComplete   = "We're unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please, try again."
    case invalidData        = "The data recieved from server was invalid. Please, try again."
}
