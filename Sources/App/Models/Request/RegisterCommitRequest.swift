//
//  RegisterCommitRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct RegisterCommitRequest: Codable
{
    var email: String
    var password: String
}

extension RegisterCommitRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<RegisterCommitRequest> {
        return try req.content.decode(RegisterCommitRequest.self).map { item in
            return item
        }
    }
}
