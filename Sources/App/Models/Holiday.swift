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
    var status: String
    
    ///Creates a new holiday
    init(holidayID: Int? = nil, leaveTypeID: Int, requestedByID: Int, actionerID: Int, createdAt: Date, updatedAt: Date? = nil, reason: String? = nil, declineReason: String? = nil, status: String)
    {
        self.holidayID = holidayID
        self.leaveTypeID = leaveTypeID
        self.requestedByID = requestedByID
        self.actionerID = actionerID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.reason = reason
        self.declineReason = declineReason
        self.status = status
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
    var holidayDateType: String
    var employeeID: Int

    ///Creates a new leave type
    init(holidayDurationID: Int? = nil, holidayID: Int, holidayDate: Date, holidayDateType: String, employeeID: Int)
    {
        self.holidayDurationID = holidayDurationID
        self.holidayID = holidayID
        self.holidayDate = holidayDate
        self.holidayDateType = holidayDateType
        self.employeeID = employeeID
    }
    
}

extension HolidayDuration: Content { }
