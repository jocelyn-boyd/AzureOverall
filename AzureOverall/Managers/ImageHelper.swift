//
//  ImageHelper.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class ImageHelper {
  
  // MARK: - Static Properties
  static let manager = ImageHelper()
  
  
  // MARK: - Private Properties and Initializers
  private init() {}
  
  
  // MARK: - Internal Properties
  func getImage(from urlString: String, completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
    NetworkHelper.manager.getData(from: urlString) { (result) in
      switch result {
      case let .failure(error):
        completionHandler(.failure(error))
      case let .success(data):
        guard let onlineImage = UIImage(data: data) else {
          completionHandler(.failure(.unableToComplete))
          return
        }
        completionHandler(.success(onlineImage))
      }
    }
  }
}
