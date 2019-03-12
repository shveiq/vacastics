//
//  HolidayReply.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

struct HolidayItemReply: Decodable {
    var id: Int
    var startDate: Date
    var startType: HolidayDateType
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case startDate = "start_date"
        case startType = "start_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        startDate = try values.decode(Date.self, forKey: .startDate)
        let startTypeStr = try values.decode(String.self, forKey: .startType)
        startType = HolidayDateType.init(rawValue: startTypeStr) ?? .morning
    }
    
    init(id: Int, startDate: Date, startType: String) {
        self.id = id
        self.startDate = startDate
        self.startType = HolidayDateType.init(rawValue: startType) ?? .morning
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

    var error: Error?
    var reply: HolidayReplyData?
    var session: GeneralSession?
    
    enum CodingKeys: String, CodingKey
    {
        case error
        case reply
        case session
    }
}

extension HolidayReply: Content {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //error = try values.decode(Error.self, forKey: .error)
        reply = try values.decodeIfPresent(HolidayReplyData.self, forKey: .reply)
        session = try values.decodeIfPresent(GeneralSession.self, forKey: .session)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(reply, forKey: .reply)
        try container.encodeIfPresent(session, forKey: .session)
    }
}
