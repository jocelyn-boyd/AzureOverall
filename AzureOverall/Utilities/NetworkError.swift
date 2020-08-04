//
//  NetworkError.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

// the enum conforms to the Error protocol and lists some of the potential things that can go wrong when getting data
enum NetworkError: String, Error {
  case unableToComplete = "Unable to complete your request. Please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data recieved from the server was invalid. Please try again."
  case unableToDecodeJSON
}
