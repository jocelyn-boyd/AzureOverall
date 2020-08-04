//
//  RecipeError.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/31/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

enum RecipeError: Error, CustomStringConvertible {
  case networkError(NetworkError)
  case jsonDecodingError(Error)
  
  var description: String {
    switch self {
    case let .networkError(networkError):
      return "Network error: \(networkError.localizedDescription)"
    case let .jsonDecodingError(decodingError):
      return "Decoding error: \(decodingError.localizedDescription)"
    }
  }
}
