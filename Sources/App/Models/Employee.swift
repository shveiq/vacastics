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
    
    ///Creates a new employee
    init(employeeID: Int? = nil, userID: Int, departmentID: Int, createdAt: Date, updatedAt: Date? = nil, startDate: Date, endDate: Date? = nil, status: String)
    {
        self.employeeID = employeeID
        self.userID = userID
        self.departmentID = departmentID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
    
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
    
    ///Creates a new employee allowance
    init(allowanceID: Int? = nil, employeeID: Int, year: Int, allowance: Int, remaining:Int, used: Int)
    {
        self.allowanceID = allowanceID
        self.employeeID = employeeID
        self.year = year
        self.allowance = allowance
        self.remaining = remaining
        self.used = used
    }
    
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

    ///Creates a new employee workday
    init(workDayID: Int? = nil, employeeID: Int, dayOfWeek: String, fromTimeAM: Int, toTimeAM: Int, fromTimePM:Int, toTimePM: Int, working: String)
    {
        self.workDayID = workDayID
        self.employeeID = employeeID
        self.dayOfWeek = dayOfWeek
        self.fromTimeAM = fromTimeAM
        self.toTimeAM = toTimeAM
        self.fromTimePM = fromTimePM
        self.toTimePM = toTimePM
        self.working = working
    }

}

extension EmployeeWorkday: Content { }
