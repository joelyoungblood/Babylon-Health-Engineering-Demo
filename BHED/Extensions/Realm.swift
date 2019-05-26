//
//  Realm.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Object {
    
    static func hasData() -> Bool {
        let realm = try! Realm()
        return realm.objects(self).count > 0
    }
}

protocol Realmable { }

extension Realmable where Self: Object {
    
    static func fetchAllWhere(key: String, matchesValue value: String) -> Results<Self> {
        let predicate = NSPredicate(format: "\(key) == \(value)")
        return fetchAll(predicate: predicate)
    }
    
    static func fetchAll(predicate: NSPredicate? = nil) -> Results<Self> {
        let realm = try! Realm()
        if let predicate = predicate {
            return realm.objects(Self.self).filter(predicate)
        }
        return realm.objects(Self.self)
    }
    
    static func fetchFirst(predicate: NSPredicate? = nil) -> Self? {
        return fetchAll(predicate: predicate).first
    }
    
    static func fetchFirstWhere(key: String, matchesValue value: String) -> Self? {
        let predicate = NSPredicate(format: "\(key) == \(value)")
        return fetchFirst(predicate: predicate)
    }
}
