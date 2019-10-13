//
//  Water.swift
//  Water control
//
//  Created by  Baecheslav on 13.10.2019.
//  Copyright © 2019  Baecheslav. All rights reserved.
//

import os.log
import UIKit

class Water: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var volume: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("waters")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let volume = "volume"
    }
    
    init(name: String, volume: String) {
        self.name = name
        self.volume = volume
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(volume, forKey: PropertyKey.volume)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Water object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let volume = aDecoder.decodeObject(forKey: PropertyKey.volume) as? String else {
            os_log("Unable to decode the volume for a Water object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name: name, volume: volume)
        
    }
}
