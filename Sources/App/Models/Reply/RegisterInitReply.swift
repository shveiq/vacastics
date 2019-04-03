//
//  RegisterInitReply.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct RegisterInitReply: Codable {
    
    var securityKey: String
    
    init(securityKey: String) {
        self.securityKey = securityKey
    }
    
    enum CodingKeys: String, CodingKey
    {
        case securityKey = "security_key"
    }
}

extension RegisterInitReply: Content { }
