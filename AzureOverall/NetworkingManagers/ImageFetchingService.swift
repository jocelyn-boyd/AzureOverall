//
//  ImageFetchingService.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class ImageFetchingService {
  
  //MARK: - Static Properties
  static let manager = ImageFetchingService()

  // MARK: - Private Properties and Initializers
  private let baseURL = "https://spoonacular.com/recipeImages"
  private init() {}
  
  //MARK: - Methods
  func fetchImage(using recipeID: Int, completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
    let endpoint = baseURL + "/\(recipeID)-556x370.jpg"
    NetworkManager.shared.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        guard let onlineImage = UIImage(data: data) else {
          completionHandler(.failure(.unableToComplete))
          return
        }
        completionHandler(.success(onlineImage))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }
  
    func fetchImage(using urlString: String, completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
    NetworkManager.shared.getData(from: urlString) { (result) in
      switch result {
      case let .success(data):
        guard let onlineImage = UIImage(data: data) else {
          completionHandler(.failure(.unableToComplete))
          return
        }
        completionHandler(.success(onlineImage))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }
}
