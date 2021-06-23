//
//  NetworkError.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

// the enum conforms to the Error protocol and lists some of the potential things that can go wrong when getting data
public enum NetworkError: CustomStringConvertible, Error {
	public var description: String {
		switch self {
		case .unableToComplete:
			return "Unable to complete your request. Please check your internet connection."
		case .invalidResponse:
			return "Invalid response from the server. Please try again."
		case .invalidData:
			return "The data recieved from the server was invalid. Please try again."
		case let .unableToDecodeJSON(error):
			return "JSONDecodingError \(error)"
		}
	}
	
	case unableToComplete
	case invalidResponse
	case invalidData
	case unableToDecodeJSON(Error)
}
