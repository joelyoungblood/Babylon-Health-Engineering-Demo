//
//  Comments.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

enum Comments: APIRoute {
    case allComments
    
    var path: String {
        switch self {
        case .allComments:
            return "comments"
        }
    }
    
    var params: JSON? {
        return nil
    }
}
