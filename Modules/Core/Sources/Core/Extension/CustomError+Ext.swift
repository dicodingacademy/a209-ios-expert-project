//
//  CustomeError+Ext.swift
//
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation

public enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)

  public var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    }
  }

}

public enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed

  public var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
