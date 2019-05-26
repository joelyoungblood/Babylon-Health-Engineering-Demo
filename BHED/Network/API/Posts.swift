//
//  Posts.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

enum Posts: APIRoute {
    case allPosts
    
    var path: String {
        switch self {
        case .allPosts:
            return "posts"
        }
    }
    
    var params: JSON? {
        switch self {
        default: return nil
        }
    }
}
