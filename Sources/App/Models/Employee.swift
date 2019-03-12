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
    var status: EmployeeStatusType
    
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
        self.status = EmployeeStatusType.init(rawValue: status) ?? .deleted
    }
    
    enum CodingKeys: String, CodingKey
    {
        case employeeID
        case userID
        case departmentID
        case createdAt
        case updatedAt
        case startDate
        case endDate
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        employeeID = try values.decode(Int.self, forKey: .employeeID)
        departmentID = try values.decode(Int.self, forKey: .departmentID)
        userID = try values.decode(Int.self, forKey: .userID)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt)
        startDate = try values.decode(Date.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Date.self, forKey: .endDate)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = EmployeeStatusType.init(rawValue: statusStr) ?? .deleted
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(employeeID, forKey: .employeeID)
        try container.encode(userID, forKey: .userID)
        try container.encode(departmentID, forKey: .departmentID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encode(startDate, forKey: .startDate)
        try container.encodeIfPresent(endDate, forKey: .endDate)
        try container.encode(status.rawValue, forKey: .status)
    }
    
}

extension Employee {
    var user: Parent<Employee, User> {
        return parent(\Employee.userID)
    }
    var department: Parent<Employee, Department> {
        return parent(\Employee.departmentID)
    }
    var allowances: Children<Employee, EmployeeAllowance> {
        return children(\EmployeeAllowance.employeeID)
    }
    var workdays: Children<Employee, EmployeeWorkday> {
        return children(\EmployeeWorkday.employeeID)
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

extension EmployeeAllowance {
    var employee: Parent<EmployeeAllowance, Employee> {
        return parent(\EmployeeAllowance.employeeID)
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

extension EmployeeWorkday {
    var employee: Parent<EmployeeWorkday, Employee> {
        return parent(\EmployeeWorkday.employeeID)
    }
}

extension EmployeeWorkday: Content { }
