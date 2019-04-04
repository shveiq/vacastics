//
//  EmployeeCreateRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct EmployeeCreateRequest: Codable
{
    
}

extension EmployeeCreateRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<EmployeeCreateRequest> {
        return try req.content.decode(EmployeeCreateRequest.self).map { item in
            return item
        }
    }
}
