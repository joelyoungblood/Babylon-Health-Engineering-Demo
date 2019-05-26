//
//  Bundle.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// The app's Realm DB name
    static var realmFilename: String {
        return "default.realm"
    }
    
    /// A `URL` to the path to the app's Library directory
    static var applicationSupportURL: URL? {
        guard var filePath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else { return nil }
        filePath = filePath.appendingPathComponent("Application Support", isDirectory: true)
        return filePath
    }
    
    /// A `URL` to the custom folder for the BabylonHealthEngineeringDemo Realm file if one exists, and creates that directory if one does not
    static var babylonHealthLibraryURL: URL? {
        guard var filePath = applicationSupportURL else { return nil }
        filePath = filePath.appendingPathComponent("com.youngblood.BHED", isDirectory: true)
        if !FileManager.default.fileExists(atPath: filePath.path) {
            try! FileManager.default.createDirectory(at: filePath, withIntermediateDirectories: true, attributes: nil)
            var resourceValue = URLResourceValues()
            resourceValue.isExcludedFromBackup = true
            try! filePath.setResourceValues(resourceValue)
        }
        return filePath
    }
    
    /// A `URL` of the path of the App's documents directory
    static var documentsURL: URL? {
        guard let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return filePath
    }
    
    var versionString: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildString: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
