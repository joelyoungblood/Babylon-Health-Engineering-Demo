//
//  Users.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

enum Users: APIRoute {
    case allUsers
    
    var path: String {
        switch self {
        case .allUsers:
            return "users"
        }
    }
    
    var params: JSON? {
        return nil
    }
}
