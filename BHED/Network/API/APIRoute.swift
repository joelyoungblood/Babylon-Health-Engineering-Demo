//
//  APIRoute.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRoute: URLRequestConvertible {
    var root: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var params: JSON? { get }
}

extension APIRoute {
    
    //We go through this step so that we could switch our root url depending on the environment, eg. prod, dev, test etc
    var root: String {
        return "http://jsonplaceholder.typicode.com/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: root + path) else { throw NetworkError.formationError(url: root + path) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
