//
//  HolidayRequest.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

struct HolidayRequestData: Decodable {

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

struct HolidayRequest: GenericRequestType {
    typealias DataType = HolidayRequestData

    var device: GeneralDevice
    var request: HolidayRequestData
    var session: GeneralSession?
    
}

extension HolidayRequest: Decodable { }

extension HolidayRequest: RequestDecodable {
    static func decode(from req: Request) throws -> EventLoopFuture<HolidayRequest> {
        return try req.content.decode(HolidayRequest.self).map { item in
            return item
        }
    }
}
