//
//  enums.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

public enum UserStatusType: String {
    case active = "ACTIVE"
    case create = "CREATE"
    case blocked = "BLOCKED"
    case deleted = "DELETED"
}

public enum UserApplicationStatusType: String {
    case active = "ACTIVE"
    case deleted = "DELETED"
}

public enum OrganisationStatusType: String {
    case active = "ACTIVE"
    case archived = "ARCHIVED"
    case deleted = "DELETED"
}

public enum DepartmentStatusType: String {
    case active = "ACTIVE"
    case archived = "ARCHIVED"
    case deleted = "DELETED"
}

public enum EmployeeStatusType: String {
    case active = "ACTIVE"
    case archived = "ARCHIVED"
    case deleted = "DELETED"
}

public enum HolidayDateType: String {
    case morning = "MORNING"
    case afternoon = "AFTERNOON"
}

public enum HolidayStatusType: String {
    case pending = "PENDING"
    case approved = "APPROVED"
    case cancelled = "CANCELLED"
    case declined = "DECLINED"
}


