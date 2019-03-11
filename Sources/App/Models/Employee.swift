//
//  Employee.swift
//  App
//
//  Created by Pawel Szenk on 11/03/2019.
//

import Vapor
import FluentMySQL

final class Employee: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \Employee.employeeID
    static let entity = "employee"
    
    var employeeID: Int?
    var userID: Int
    var departmentID: Int
    var createdAt: Date
    var updatedAt: Date?
    var startDate: Date
    var endDate: Date?
    var status: String
    
}

extension Employee: Content { }

final class EmployeeAllowance: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \EmployeeAllowance.allowanceID
    static let entity = "employee_allowance"
    
    var allowanceID: Int?
    var employeeID: Int
    var year: Int
    var allowance: Int
    var remaining: Int
    var used: Int
    
}

extension EmployeeAllowance: Content { }

final class EmployeeWorkday: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \EmployeeWorkday.workDayID
    static let entity = "employee_workday"
    
    var workDayID: Int?
    var employeeID: Int
    var dayOfWeek: String
    var fromTimeAM: Int
    var toTimeAM: Int
    var fromTimePM: Int
    var toTimePM: Int
    var working: String

}

extension EmployeeWorkday: Content { }
