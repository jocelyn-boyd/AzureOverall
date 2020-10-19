//
//  NetworkHelper.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class NetworkManager {
  
  // MARK: - Static Properties
  static let shared = NetworkManager()
  
  
  // MARK: - Private Properties and Initializers
  private let urlSession = URLSession(configuration: .default)
  private init() {}
  
  
  // MARK: - Methods
  internal func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
    
    guard let url = URL(string: urlString) else {
      completionHandler(.failure(.unableToComplete))
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let _ = error {
        completionHandler(.failure(.unableToComplete))
        return
      }
      
      guard let urlResponse = response as? HTTPURLResponse else {
        completionHandler(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(.invalidData))
        return
      }
      
      switch urlResponse.statusCode {
      case 200...299: break
      default:
        completionHandler(.failure(.invalidResponse))
        return
      }
      completionHandler(.success(data))
    }

    dataTask.resume()
  }
}
