//
//  RegisterController.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor
import Crypto

final class RegisterController {
    
    func index(_ req: Request) throws -> Future<RegisterInitReply> {
        
        let securityKey = try CryptoRandom().generateData(count: 32).base64EncodedString()
        let session = try req.appSession()
        session["securityKey"] = securityKey
        let reply = RegisterInitReply(securityKey: securityKey)
        
        return req.next().newSucceededFuture(result: reply)
    }
    
    func register(_ req: Request, _ loginRequest: RegisterCommitRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
}


