//
//  Address.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers final class Address: Object, Decodable {
    dynamic var street: String = ""
    dynamic var suite: String = ""
    dynamic var city: String = ""
    dynamic var zipcode: String = ""
    dynamic var geoLocation: GeoLocation? = nil
    
    private enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geoLocation = "geo"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        street = try container.decode(String.self, forKey: .street)
        suite = try container.decode(String.self, forKey: .suite)
        city = try container.decode(String.self, forKey: .city)
        zipcode = try container.decode(String.self, forKey: .zipcode)
        geoLocation = try container.decode(GeoLocation.self, forKey: .geoLocation)
        
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

@objcMembers final class GeoLocation: Object, Decodable {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latString = try container.decode(String.self, forKey: .latitude)
        latitude = Double(latString) ?? 0.0
        let longString = try container.decode(String.self, forKey: .longitude)
        longitude = Double(longString) ?? 0.0
        
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
