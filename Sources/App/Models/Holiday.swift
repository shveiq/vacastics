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

}

extension HolidayDuration: Content { }
