//
//  OrganisationModifyRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct OrganisationModifyRequest: Codable
{
    
}

extension OrganisationModifyRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<OrganisationModifyRequest> {
        return try req.content.decode(OrganisationModifyRequest.self).map { item in
            return item
        }
    }
}
