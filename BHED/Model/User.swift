//
//  User.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers final class User: Object, Decodable, Realmable {
    dynamic var id: Int = -1
    dynamic var name: String = ""
    dynamic var username: String = ""
    dynamic var address: Address? = nil
    dynamic var phone: String = ""
    dynamic var website: String = ""
    dynamic var company: Company? = nil
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case address
        case phone
        case website
        case company
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        address = try container.decode(Address.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
        website = try container.decode(String.self, forKey: .website)
        company = try container.decode(Company.self, forKey: .company)
        
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
