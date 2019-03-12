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
    var bossID: Int
    var createdAt: Date
    var updatedAt: Date?
    var countryCode: String
    var status: String
    
    ///Creates a new organisation
    init(organisationID: Int? = nil, name: String, bossID: Int, createdAt: Date, updatedAt: Date? = nil, countryCode: String, status: String)
    {
        self.organisationID = organisationID
        self.name = name
        self.bossID = bossID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.countryCode = countryCode
        self.status = status
    }
    
}

extension Organisation {
    var boss: Parent<Organisation, User> {
        return parent(\Organisation.bossID)
    }
    var departments: Children<Organisation, Department> {
        return children(\Department.organisationID)
    }
}

extension Organisation: Content { }
