//
//  LoginCommitRequest.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

struct LoginCommitRequest: Codable
{
    var email: String
    var password: String
    var loginToken: String
}

extension LoginCommitRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<LoginCommitRequest> {
        return try req.content.decode(LoginCommitRequest.self).map { item in
            return item
        }
    }
}
