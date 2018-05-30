//
//  HeadLines.swift
//  WorldNews
//
//  Created by David on 17/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import Foundation
import Freddy

struct HeadLines : JSONDecodable  {
    init(json: JSON) throws {
        author = try json.getString(at :"author", alongPath: .nullBecomesNil)
        title = try json.getString(at :"title")
        description = try json.getString(at :"description", alongPath : .nullBecomesNil)
        url = try json.getString(at: "url")
        urlToImage = try json.getString(at: "urlToImage", alongPath: .nullBecomesNil)
        source = try json.decode(at: "source");
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        publishedAt = try formatter.date(from :json.getString(at: "publishedAt"))!
    }
    
    let author, urlToImage, description : String?
    let title, url : String
    let source : Source
    let publishedAt : Date
}
