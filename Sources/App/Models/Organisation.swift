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
    var status: OrganisationStatusType
    
    ///Creates a new organisation
    init(organisationID: Int? = nil, name: String, bossID: Int, createdAt: Date, updatedAt: Date? = nil, countryCode: String, status: String)
    {
        self.organisationID = organisationID
        self.name = name
        self.bossID = bossID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.countryCode = countryCode
        self.status = OrganisationStatusType.init(rawValue: status) ?? .deleted
    }
    
    enum CodingKeys: String, CodingKey
    {
        case organisationID
        case name
        case bossID
        case createdAt
        case updatedAt
        case countryCode
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        organisationID = try values.decode(Int.self, forKey: .organisationID)
        name = try values.decode(String.self, forKey: .name)
        bossID = try values.decode(Int.self, forKey: .bossID)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt)
        countryCode = try values.decode(String.self, forKey: .countryCode)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = OrganisationStatusType.init(rawValue: statusStr) ?? .deleted
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(organisationID, forKey: .organisationID)
        try container.encode(name, forKey: .name)
        try container.encode(bossID, forKey: .bossID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(status.rawValue, forKey: .status)
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
