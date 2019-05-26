//
//  Request.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import RxSwift

final class Request {
    
    private static let decoder  = JSONDecoder()
    
    static func allPosts() -> Observable<[Post]> {
        return Network.request(fromRoute: Posts.allPosts).map { data in
            do {
                let posts = try decoder.decode([Post].self, from: data)
                return posts
            } catch let error {
                throw DecodeError<Post>.decode(error: error)
            }
        }
    }
    
    static func allUsers() -> Observable<[User]> {
        return Network.request(fromRoute: Users.allUsers).map { data in
            do {
                let users = try decoder.decode([User].self, from: data)
                return users
            } catch let error {
                throw DecodeError<User>.decode(error: error)
            }
        }
    }
    
    static func allComments() -> Observable<[Comment]> {
        return Network.request(fromRoute: Comments.allComments).map { data in
            do {
                let comments = try decoder.decode([Comment].self, from: data)
                return comments
            } catch let error {
                throw DecodeError<Comment>.decode(error: error)
            }
        }
    }
}
