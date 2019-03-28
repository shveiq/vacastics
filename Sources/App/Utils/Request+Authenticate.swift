//
//  Request+Authenticate.swift
//  App
//
//  Created by Pawel Szenk on 28/03/2019.
//

import Vapor

internal final class AuthenticateCache: ServiceType {
    /// See `ServiceType`.
    static func makeService(for worker: Container) throws -> AuthenticateCache {
        return .init()
    }
    
    /// The cached session.
    var user: User?
    
    /// Creates a new `SessionCache`.
    init(user: User? = nil) {
        self.user = user
    }
}

public struct AuthenticationError: Debuggable {
    /// See Debuggable.readableName
    public static let readableName = "Authentication Error"
    
    /// See Debuggable.reason
    public let identifier: String
    
    /// See Debuggable.reason
    public var reason: String
    
    /// See Debuggable.sourceLocation
    public var sourceLocation: SourceLocation?
    
    /// See stackTrace
    public var stackTrace: [String]
    
    /// Create a new authentication error.
    init(
        identifier: String,
        reason: String,
        source: SourceLocation
        ) {
        self.identifier = identifier
        self.reason = reason
        self.sourceLocation = source
        self.stackTrace = AuthenticationError.makeStackTrace()
    }
}

extension AuthenticationError: AbortError {
    /// See AbortError.status
    public var status: HTTPStatus {
        return .unauthorized
    }
}

extension Request {
    
    public func authenticate(_ user: User) throws
    {
        let cache = try privateContainer.make(AuthenticateCache.self)
        cache.user = user
    }
    
    public func authenticated() throws -> User?
    {
        let cache = try privateContainer.make(AuthenticateCache.self)
        return cache.user
    }
    
    public func isAuthenticated() throws -> Bool
    {
        return try authenticated() != nil
    }
    
    public func requiredAuthenticated() throws -> User
    {
        guard let a = try authenticated() else {
            throw AuthenticationError(
                identifier: "notAuthenticated",
                reason: "Has not been authenticated.",
                source: .capture()
            )
        }
        return a
    }
    
}
