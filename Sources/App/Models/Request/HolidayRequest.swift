//
//  HolidayRequest.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

struct HolidayRequest: Codable {

    var departmentID: Int?
    var userIDs: [Int]?
    var exclusionUserIDs: [Int]?
    var nonArchivedUserOnly: Bool?
    var start: Date?
    var end: Date?
    var status: Int?
    var approverID: Int?
    var pageNumber: Int?

}

extension HolidayRequest: RequestDecodable {
    
    static func decode(from req: Request) throws -> EventLoopFuture<HolidayRequest> {
        return try req.content.decode(HolidayRequest.self).map { item in
            return item
        }
    }
    
}
