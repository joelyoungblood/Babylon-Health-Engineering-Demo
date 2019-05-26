//
//  Post.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers final class Post: Object, Decodable {
    dynamic var userId: Int = -1
    dynamic var id: Int = -1
    dynamic var title: String = ""
    dynamic var body: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try container.decode(Int.self, forKey: .userId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
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
