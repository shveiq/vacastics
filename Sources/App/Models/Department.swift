//
//  Department.swift
//  App
//
//  Created by Pawel Szenk on 11/03/2019.
//

import Vapor
import FluentMySQL

final class Department: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \Department.departmentID
    static let entity = "department"
    
    var departmentID: Int?
    var organisationID: Int
    var name: String
    var bossId: Int
    var createdAt: Date
    var updatedAt: Date?
    var status: String
    
    ///Creates a new department
    init(departmentID: Int? = nil, organisationID: Int, name: String, bossId: Int, createdAt: Date, updatedAt: Date? = nil, status: String)
    {
        self.departmentID = departmentID
        self.organisationID = organisationID
        self.name = name
        self.bossId = bossId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
    }
    
}

extension Department: Content { }
