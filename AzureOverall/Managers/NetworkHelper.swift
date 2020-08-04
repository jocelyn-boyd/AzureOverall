//
//  NetworkHelper.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/31/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

class NetworkHelper {
  // MARK: - Static Properties
  
  // because there is only one instance (named manager), there's a guarantee that anywhere in the app that reads from or writes to the NetworkHelper is looking at the same place
  static let manager = NetworkHelper() // type property
  
  // MARK: - Internal Methods
  
  func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
    
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
    // make the call to get data from the URL by using the data task's reume()
    dataTask.resume()
  }
  // MARK: - Private Properties and Initializers
  
  private let urlSession = URLSession(configuration: .default)
  
  // mark the initializer as private to only create NetworkHelper instances inside of our class
  private init() {}
  
}
