//
//  Sources.swift
//  WorldNews
//
//  Created by David on 17/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import Foundation
import Freddy

class Source : JSONDecodable{
    
    required init(json: JSON) throws {
        id = try json.getString(at: "id", alongPath: .nullBecomesNil)
        name = try json.getString(at :"name")
        isEnabled = false
    }
    
    init(id : String, name : String, isEnabled : Bool) {
        self.id = id
        self.name = name
        self.isEnabled = isEnabled
    }
    
    var id : String?
    var name : String
    var isEnabled : Bool
}
