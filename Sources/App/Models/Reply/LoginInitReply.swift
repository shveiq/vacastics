//
//  LoginInitReply.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

struct LoginInitReply: Codable {
    
    var loginToken: String
    
    init(loginToken: String) {
        self.loginToken = loginToken
    }
    
}

extension LoginInitReply: Content { }
