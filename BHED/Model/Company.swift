//
//  Company.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers final class Company: Object, Decodable {
    dynamic var name: String = ""
    dynamic var catchPrahse: String = ""
    dynamic var marketingBs: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case marketingBs = "bs"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        catchPrahse = try container.decode(String.self, forKey: .catchPhrase)
        marketingBs = try container.decode(String.self, forKey: .marketingBs)
        
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
