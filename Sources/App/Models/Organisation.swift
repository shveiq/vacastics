//
//  Organisation.swift
//  App
//
//  Created by Pawel Szenk on 11/03/2019.
//

import Vapor
import FluentMySQL

final class Organisation: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \Organisation.organisationID
    static let entity = "organisation"
    
    var organisationID: Int?
    var name: String
    var bossId: Int
    var createdAt: Date
    var updatedAt: Date?
    var countryCode: String
    var status: String
    
}

extension Organisation: Content { }
