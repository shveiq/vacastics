//
//  Holiday.swift
//  App
//
//  Created by Pawel Szenk on 11/03/2019.
//

import Vapor
import FluentMySQL

final class Holiday: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \Holiday.holidayID
    static let entity = "holiday"
    
    var holidayID: Int?
    var leaveTypeID: Int
    var requestedByID: Int
    var actionerID: Int?
    var createdAt: Date
    var updatedAt: Date?
    var reason: String?
    var declineReason: String?
    var status: HolidayStatusType
    
    ///Creates a new holiday
    init(holidayID: Int? = nil, leaveTypeID: Int, requestedByID: Int, actionerID: Int? = nil, createdAt: Date, updatedAt: Date? = nil, reason: String? = nil, declineReason: String? = nil, status: String)
    {
        self.holidayID = holidayID
        self.leaveTypeID = leaveTypeID
        self.requestedByID = requestedByID
        self.actionerID = actionerID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.reason = reason
        self.declineReason = declineReason
        self.status = HolidayStatusType.init(rawValue: status) ?? .pending
    }
    
    enum CodingKeys: String, CodingKey
    {
        case holidayID
        case leaveTypeID
        case requestedByID
        case actionerID
        case createdAt
        case updatedAt
        case reason
        case declineReason
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        holidayID = try values.decode(Int.self, forKey: .holidayID)
        leaveTypeID = try values.decode(Int.self, forKey: .leaveTypeID)
        requestedByID = try values.decode(Int.self, forKey: .requestedByID)
        actionerID = try values.decodeIfPresent(Int.self, forKey: .actionerID)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        declineReason = try values.decodeIfPresent(String.self, forKey: .declineReason)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = HolidayStatusType.init(rawValue: statusStr) ?? .pending
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(holidayID, forKey: .holidayID)
        try container.encode(leaveTypeID, forKey: .leaveTypeID)
        try container.encode(requestedByID, forKey: .requestedByID)
        try container.encodeIfPresent(actionerID, forKey: .actionerID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(declineReason, forKey: .declineReason)
        try container.encode(status.rawValue, forKey: .status)
    }
    
}

extension Holiday {
    var requestedBy: Parent<Holiday, Employee> {
        return parent(\Holiday.requestedByID)
    }
    var actioner: Parent<Holiday, Employee>? {
        return parent(\Holiday.actionerID)
    }
    var leaveType: Parent<Holiday, LeaveType> {
        return parent(\Holiday.leaveTypeID)
    }
    var durations: Children<Holiday, HolidayDuration> {
        return children(\HolidayDuration.holidayID)
    }
}

extension Holiday: Content { }

final class HolidayDuration: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \HolidayDuration.holidayDurationID
    static let entity = "holiday_duration"
    
    var holidayDurationID: Int?
    var holidayID: Int
    var holidayDate: Date
    var holidayDateType: HolidayDateType
    var employeeID: Int

    ///Creates a new leave type
    init(holidayDurationID: Int? = nil, holidayID: Int, holidayDate: Date, holidayDateType: String, employeeID: Int)
    {
        self.holidayDurationID = holidayDurationID
        self.holidayID = holidayID
        self.holidayDate = holidayDate
        self.holidayDateType = HolidayDateType.init(rawValue: holidayDateType) ?? .morning
        self.employeeID = employeeID
    }
    
    enum CodingKeys: String, CodingKey
    {
        case holidayDurationID
        case holidayID
        case holidayDate
        case holidayDateType
        case employeeID
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        holidayDurationID = try values.decode(Int.self, forKey: .holidayDurationID)
        holidayID = try values.decode(Int.self, forKey: .holidayID)
        holidayDate = try values.decode(Date.self, forKey: .holidayDate)
        let holidayDateTypeStr = try values.decode(String.self, forKey: .holidayDateType)
        holidayDateType = HolidayDateType.init(rawValue: holidayDateTypeStr) ?? .morning
        employeeID = try values.decode(Int.self, forKey: .employeeID)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(holidayDurationID, forKey: .holidayDurationID)
        try container.encode(holidayID, forKey: .holidayID)
        try container.encode(holidayDate, forKey: .holidayDate)
        try container.encode(holidayDateType.rawValue, forKey: .holidayDateType)
        try container.encode(employeeID, forKey: .employeeID)
    }
    
}

extension HolidayDuration {
    var holiday: Parent<HolidayDuration, Holiday> {
        return parent(\HolidayDuration.holidayID)
    }
    var employee: Parent<HolidayDuration, Employee> {
        return parent(\HolidayDuration.employeeID)
    }
}

extension HolidayDuration: Content { }
