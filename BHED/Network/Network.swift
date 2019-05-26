//
//  Network.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

typealias JSON = [String: Any]

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

final class Network {
    
    private static let reachability = NetworkReachabilityManager()!
    
    static func request(fromRoute route: APIRoute) -> Observable<Data> {
        if !reachability.isReachable {
            return Observable.error(NetworkError.noConnection)
        } else {
            return RxAlamofire.request(route).responseData().flatMap { response -> Observable<Data> in
                let result = response.0
                if result.statusCode == 200 {
                    let data = response.1
                    return Observable.just(data)
                } else {
                    return Observable.error(NetworkError.errorCode(code: result.statusCode))
                }
            }
        }
    }
}
