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
    var bossID: Int
    var createdAt: Date
    var updatedAt: Date?
    var status: DepartmentStatusType
    
    ///Creates a new department
    init(departmentID: Int? = nil, organisationID: Int, name: String, bossID: Int, createdAt: Date, updatedAt: Date? = nil, status: String)
    {
        self.departmentID = departmentID
        self.organisationID = organisationID
        self.name = name
        self.bossID = bossID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = DepartmentStatusType.init(rawValue: status) ?? .deleted
    }
    
    enum CodingKeys: String, CodingKey
    {
        case departmentID
        case organisationID
        case name
        case bossID
        case createdAt
        case updatedAt
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        departmentID = try values.decode(Int.self, forKey: .departmentID)
        organisationID = try values.decode(Int.self, forKey: .organisationID)
        name = try values.decode(String.self, forKey: .name)
        bossID = try values.decode(Int.self, forKey: .bossID)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = DepartmentStatusType.init(rawValue: statusStr) ?? .deleted
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(departmentID, forKey: .departmentID)
        try container.encode(organisationID, forKey: .organisationID)
        try container.encode(name, forKey: .name)
        try container.encode(bossID, forKey: .bossID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encode(status.rawValue, forKey: .status)
    }
}

extension Department {
    var boss: Parent<Department, User> {
        return parent(\Department.bossID)
    }
    var organisation: Parent<Department, Organisation> {
        return parent(\Department.organisationID)
    }
    var employees: Children<Department, Employee> {
        return children(\Employee.departmentID)
    }
}

extension Department: Content { }

extension Department: Parameter { }
