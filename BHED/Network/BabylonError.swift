//
//  BabylonError.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

//Normally I'd have including CustomDebugStringConvertible here too, for additional debug details, but time/scope means this error handling is in general very limited
protocol BabylonError: Error, CustomStringConvertible { }

enum NetworkError: BabylonError {
    case noConnection
    case formationError(url: String)
    case errorCode(code: Int)
    
    var description: String {
        switch self {
        case .noConnection:
            return "No internet connection detected. If you are not seeing any data, the initial sync must not have been performed. Please check your connectionn and refresh."
        case .formationError(let url):
            return "Failed to form a correct URL for path \(url)"
        case .errorCode(let code):
            return "There was a network error, server returned response code - \(code)"
        }
    }
}

enum RealmError: BabylonError {
    case noData
    case connectionError
    case save(error: Error, elements: Any)
    
    var description: String {
        switch self {
        case .noData:
            return "There was no data synced to the Realm DB - please check your internet connection and refresh."
        case .connectionError:
            return "Unable to connect to the Realm DB"
        case .save(let error, let elements):
            return "Error \(error.localizedDescription) while saving objects \(String(describing: elements))"
        }
    }
}

enum DecodeError<T>: BabylonError {
    case decode(error: Error)
    
    var description: String {
        switch self {
        case .decode(let error):
            return "Decoding model of type \(T.self) failed with error \(error.localizedDescription)"
        }
    }
}
