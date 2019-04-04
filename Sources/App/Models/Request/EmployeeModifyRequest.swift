//
//  EmployeeModifyRequest.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

struct EmployeeModifyRequest: Codable
{
    
}

extension EmployeeModifyRequest: RequestDecodable
{
    static func decode(from req: Request) throws -> EventLoopFuture<EmployeeModifyRequest> {
        return try req.content.decode(EmployeeModifyRequest.self).map { item in
            return item
        }
    }
}
