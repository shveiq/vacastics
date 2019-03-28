//
//  AuthController.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

final class AuthController {
    
    func index(_ req: Request) throws -> Future<LoginInitReply> {

        let loginToken = "aaaaaaassssss"
        let session = try req.appSession()
        session["loginToken"] = loginToken
        let reply = LoginInitReply(loginToken: loginToken)

        return req.next().newSucceededFuture(result: reply)
    }
    
    func login(_ req:Request, _ loginRequest: LoginCommitRequest) throws -> Future<LoginCommitReply> {
        return req.withPooledConnection(to: .mysql) { conn in
            return User.query(on: conn).filter(\User.email, .equal, loginRequest.email).first()
            }.map { user in
                return LoginCommitReply(user: user!)
            }
    }
}
