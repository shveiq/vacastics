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
    var reply: HolidayReplyData?
    var session: GeneralSession?

}

extension HolidayReply: Codable {
    
    enum CodingKeys: String, CodingKey
    {
        case error
        case reason
        case reply
        case session
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        reply = try values.decodeIfPresent(HolidayReplyData.self, forKey: .reply)
        session = try values.decodeIfPresent(GeneralSession.self, forKey: .session)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(reply, forKey: .reply)
        try container.encodeIfPresent(session, forKey: .session)
    }
    
}

extension HolidayReply: Content { }
