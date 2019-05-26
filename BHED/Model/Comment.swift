//
//  Comment.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers final class Comment: Object, Decodable, Realmable {
    dynamic var postId: Int = -1
    dynamic var id: Int = -1
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var body: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        postId = try container.decode(Int.self, forKey: .postId)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        body = try container.decode(String.self, forKey: .body)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
