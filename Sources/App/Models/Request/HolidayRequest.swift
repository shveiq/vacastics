//
//  HolidayRequest.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

struct HolidayRequestData: Codable {

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

extension HolidayRequest: Codable {
    
    enum CodingKeys: String, CodingKey
    {
        case device
        case request
        case session
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        device = try values.decode(GeneralDevice.self, forKey: .device)
        request = try values.decode(HolidayRequestData.self, forKey: .request)
        session = try values.decodeIfPresent(GeneralSession.self, forKey: .session)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(device, forKey: .device)
        try container.encode(request, forKey: .request)
        try container.encodeIfPresent(session, forKey: .session)
    }
    
}

extension HolidayRequest: RequestDecodable {
    
    static func decode(from req: Request) throws -> EventLoopFuture<HolidayRequest> {
        return try req.content.decode(HolidayRequest.self).map { item in
            return item
        }
    }
    
}
