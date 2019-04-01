//
//  AuthenticateMiddleware.swift
//  App
//
//  Created by Pawel Szenk on 30/03/2019.
//

import Vapor

public final class AuthenticateMiddleware: Middleware, ServiceType {
    
    public static func makeService(for container: Container) throws -> Self {
        return .init();
    }
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        _ = try req.requiredAuthenticated()
        return try next.respond(to: req)
    }

}
