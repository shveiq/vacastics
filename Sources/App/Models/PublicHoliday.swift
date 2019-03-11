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
    
}

extension PublicHoliday: Content { }
