//
//  OrganisationCreateRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct OrganisationCreateRequest: Codable
{
    
}

extension OrganisationCreateRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<OrganisationCreateRequest> {
        return try req.content.decode(OrganisationCreateRequest.self).map { item in
            return item
        }
    }
}
