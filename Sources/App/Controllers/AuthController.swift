//
//  AuthController.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor
import Crypto

final class AuthController {
    
    func index(_ req: Request) throws -> Future<LoginInitReply> {

        let securityKey = try CryptoRandom().generateData(count: 32).base64EncodedString()
        let session = try req.appSession()
        session["securityKey"] = securityKey
        let reply = LoginInitReply(securityKey: securityKey)

        return req.next().newSucceededFuture(result: reply)
    }
    
    func login(_ req: Request, _ loginRequest: LoginCommitRequest) throws -> Future<LoginCommitReply> {
        return req.withPooledConnection(to: .mysql) { conn in
            return User.query(on: conn).filter(\User.email, .equal, loginRequest.email).first()
            }.map { user in
                let session = try req.appSession()
                if let user = user,
                    loginRequest.password.lengthOfBytes(using: .utf8) > 32,
                    let keyBase64 = session["securityKey"],
                    let key = Data(base64Encoded: keyBase64),
                    key.count == 32 {
                    
                    let password = try AesUtils.decode(loginRequest.password, key: key)
                    if user.password == password {
                        try req.authenticate(user)
                        return LoginCommitReply(user: user)
                    }
                }
                
                throw AuthenticationError(
                    identifier: "notAuthenticated",
                    reason: "Has not been authenticated.",
                    source: .capture()
                )
                
            }
    }
}
