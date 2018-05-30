//
//  Sources.swift
//  WorldNews
//
//  Created by David on 17/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import Foundation
import Freddy

struct Source : JSONDecodable{
    
    init(json: JSON) throws {
        id = try json.getString(at: "id", alongPath: .nullBecomesNil)
        name = try json.getString(at :"name")
    }
    
    let id : String?
    let name : String
}
