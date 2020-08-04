//
//  ImageFetchingService.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/31/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class ImageFetchingService {
  
  //MARK: - Static Properties
  static let manager = ImageFetchingService()
  
  
  // MARK: - Private Properties and Initializers
  private let baseURL = "https://spoonacular.com/recipeImages"
  private init() {}

  
  //MARK: - Internal Methods
  func downloadImage(from recipeID: Int, completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
    let endpoint = baseURL + "/\(recipeID)-556x370.jpg"
    
    NetworkHelper.manager.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        guard let onlineImage = UIImage(data: data) else {
          completionHandler(.failure(.couldNotDecode))
          return
        }
        completionHandler(.success(onlineImage))
        
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }
}
