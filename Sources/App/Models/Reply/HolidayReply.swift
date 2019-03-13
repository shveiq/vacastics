//
//  HolidayReply.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

struct HolidayItemReply {
    var id: Int
    var startDate: Date
    var startType: HolidayDateType
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case startDate = "start_date"
        case startType = "start_type"
    }

    init(id: Int, startDate: Date, startType: String) {
        self.id = id
        self.startDate = startDate
        self.startType = HolidayDateType.init(rawValue: startType) ?? .morning
    }

}

extension HolidayItemReply: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        startDate = try values.decode(Date.self, forKey: .startDate)
        let startTypeStr = try values.decode(String.self, forKey: .startType)
        startType = HolidayDateType.init(rawValue: startTypeStr) ?? .morning
    }
    
}

extension HolidayItemReply: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(startType.rawValue, forKey: .startType)
    }
    
}

struct HolidayReplyData: Codable {
    
    var holidays: [HolidayItemReply]
    var totalRecords: Int
    var pageNumber: Int
    
}

struct HolidayReply: GenericResponseType {
    typealias DataType = HolidayReplyData

    var error: Bool?
    var reason: String?
    var reply: HolidayReplyData
    var session: GeneralSession?

}

extension HolidayReply: Codable { }

extension HolidayReply: Content { }
