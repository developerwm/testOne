//
//  ListModel.swift
//  testJobOne
//
//  Created by Tauã on 19/03/20.
//  Copyright © 2020 Tauã. All rights reserved.
//

import Foundation
import ObjectMapper

class ListModel: Mappable {
    
    var results: [Item]?
    
    required init?(map: Map){
    }
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        results <- map["items"]
    }
    
    class Item: Mappable {
        
        var name: String?
        var full_name: String?
        var open_issues: Int?
        var stargazers_count: Int?
        var description: String?
        var owner: Owner?
        
        required init?(map: Map){
        }
        
        init() {
        }
        
        func mapping(map: Map) {
            name <- map["name"]
            full_name <- map["full_name"]
            open_issues <- map["open_issues"]
            stargazers_count <- map["stargazers_count"]
            description <- map["description"]
            owner <- map["owner"]
        }
    }
    
    class Owner: Mappable {
        
        var avatar_url: String?
        var login: String?
        
        required init?(map: Map){
        }
        
        init() {
        }
        
        func mapping(map: Map) {
            avatar_url <- map["avatar_url"]
            login <- map["login"]
        }
    }
}


