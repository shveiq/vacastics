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
    
}

extension LeaveType: Content { }
