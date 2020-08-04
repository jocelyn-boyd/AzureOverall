//
//  AOError.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/31/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

// the enum conforms to the Error protocol and lists some of the potential things that can go wrong when getting data

enum NetworkError: Error {
  case unauthenticated
  case invalidResponse
  case couldNotParseJSON(rawError: Error)
  case noInternetConnection
  case badURL
  case badStatusCode
  case noDataReceived
  case notAnImage
  case other(rawError: Error)
  case couldNotEncode
  case responseError
  case unableToComplete
  case invalidData
  case badURLResponse
  case decodingError
}
