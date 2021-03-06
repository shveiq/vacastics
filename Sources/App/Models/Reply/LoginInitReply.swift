//
//  LoginInitReply.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

struct LoginInitReply: Codable {
    
    var securityKey: String
    
    init(securityKey: String) {
        self.securityKey = securityKey
    }
    
    enum CodingKeys: String, CodingKey
    {
        case securityKey = "security_key"
    }
    
}

extension LoginInitReply: Content { }
