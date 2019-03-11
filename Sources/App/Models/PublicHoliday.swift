//
//  PublicHoliday.swift
//  App
//
//  Created by Pawel Szenk on 11/03/2019.
//

import Vapor
import FluentMySQL

final class PublicHoliday: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \PublicHoliday.publicHolidayID
    static let entity = "public_holiday"
    
    var publicHolidayID: Int?
    var countryCode: String
    var name: String
    var date: Date
    var createdAt: Date
    var updatedAt: Date?
    
    /// Creates a new public holiday.
    init(publicHolidayID: Int? = nil, countryCode: String, name: String, date: Date, createdAt: Date, updatedAt: Date? = nil) {
        self.publicHolidayID = publicHolidayID
        self.countryCode = countryCode
        self.name = name
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}

extension PublicHoliday: Content { }
