//
//  DepartmentCreateRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct DepartmentCreateRequest: Codable
{

}

extension DepartmentCreateRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<DepartmentCreateRequest> {
        return try req.content.decode(DepartmentCreateRequest.self).map { item in
            return item
        }
    }
}
