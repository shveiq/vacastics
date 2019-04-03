//
//  UserController.swift
//  App
//
//  Created by Pawel Szenk on 03/04/2019.
//

import Vapor

final class UserController {
    
    func organisations(_ req: Request) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func organisation_details(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Organisation.self).flatMap { department in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func organisation_create(_ req: Request, _ organisationCreate: OrganisationCreateRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func organisation_modify(_ req: Request, _ organisationModify: OrganisationModifyRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func organisation_delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Organisation.self).flatMap { department in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func departments(_ req: Request) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }

    func department_details(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Department.self).flatMap { department in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func department_create(_ req: Request, _ departmentCreate: DepartmentCreateRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func department_modify(_ req: Request, _ departmentModify: DepartmentModifyRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func department_delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Department.self).flatMap { department in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func employees(_ req: Request) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func employee_details(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Employee.self).flatMap { employee in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func employee_create(_ req: Request, _ employeeCreate: EmployeeCreateRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func employee_modify(_ req: Request, _ employeeModify: EmployeeModifyRequest) throws -> Future<HTTPStatus> {
        return req.withPooledConnection(to: .mysql) { conn in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
    
    func employee_delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Employee.self).flatMap { employee in
            return req.next().newSucceededFuture(result: HTTPStatus.ok)
        }
    }
}
