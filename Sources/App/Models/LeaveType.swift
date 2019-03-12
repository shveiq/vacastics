//
//  LeaveType.swift
//  App
//
//  Created by Pawel Szenk on 11/03/2019.
//

import Vapor
import FluentMySQL

final class LeaveType: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \LeaveType.leaveTypeID
    static let entity = "leave_type"
    
    var leaveTypeID: Int?
    var organisationID: Int
    var name: String
    var requiresApproval: String
    var createdAt: Date
    var updatedAt: Date?
    var color: String
    
    ///Creates a new leave type
    init(leaveTypeID: Int? = nil, organisationID: Int, name: String, requiresApproval: String, createdAt: Date, updatedAt: Date? = nil, color: String)
    {
        self.leaveTypeID = leaveTypeID
        self.organisationID = organisationID
        self.name = name
        self.requiresApproval = requiresApproval
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.color = color
    }
    
}

extension LeaveType {
    var organisation: Parent<LeaveType, Organisation> {
        return parent(\LeaveType.organisationID)
    }
}

extension LeaveType: Content { }
