//
//  DepartmentModifyRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//


import Vapor

struct DepartmentModifyRequest: Codable
{
    
}

extension DepartmentModifyRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<DepartmentModifyRequest> {
        return try req.content.decode(DepartmentModifyRequest.self).map { item in
            return item
        }
    }
}
