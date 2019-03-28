//
//  extensions.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

extension Request {
    
    public func appSession() throws -> Session {
        let cache = try privateContainer.make(OwnSessionCache.self)
        guard cache.middlewareFlag else {
            throw VaporError(
                identifier: "sessionsMiddlewareFlag",
                reason: "No `SessionsMiddleware` detected.",
                suggestedFixes: [
                    "Add the `SessionsMiddleware` globally to your app using `MiddlewareConfig`.",
                    "Add the `SessionsMiddleware` to a route group."
                ]
            )
        }
        if let existing = cache.session {
            return existing
        } else {
            let new = Session()
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let calendar = Calendar.current
            let timeLife = calendar.date(byAdding: .hour, value: 1, to: Date())
            
            new["appSessionTimeLife"] = dateFormatter.string(from: timeLife!)
            
            cache.session = new
            return new
        }
    }
    
    /// Returns `true` if this `Request` has an active session.
    public func hasAppSession() throws -> Bool {
        return try privateContainer.make(OwnSessionCache.self).session != nil
    }
    
    /// Destroys the current session, if one exists.
    public func destroyAppSession() throws {
        let cache = try privateContainer.make(OwnSessionCache.self)
        cache.session = nil
    }
    
}


/*
public protocol Authenticatable { }

final class AuthenticationCache: Service {
    /// The internal storage.
    private var storage: [ObjectIdentifier: Any]
    
    /// Create a new authentication cache.
    init() {
        self.storage = [:]
    }
    
    /// Access the cache using types.
    internal subscript<A>(_ type: A.Type) -> A?
        where A: Authenticatable
    {
        get { return storage[ObjectIdentifier(A.self)] as? A }
        set { storage[ObjectIdentifier(A.self)] = newValue }
    }
}

/// Errors that can be thrown while working with Authentication.
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
    
    public func authenticate<A>(_ instance: A) throws
        where A: Authenticatable
    {
        let cache = try privateContainer.make(AuthenticationCache.self)
        cache[A.self] = instance
    }
    
    public func authenticated<A>(_ type: A.Type = A.self) throws -> A?
        where A: Authenticatable
    {
        let cache = try privateContainer.make(AuthenticationCache.self)
        return cache[A.self]
    }
    
    public func isAuthenticated<A>(_ type: A.Type = A.self) throws -> Bool
        where A: Authenticatable
    {
        return try authenticated(A.self) != nil
    }
    
    public func requiredAuthenticated<A>(_ type: A.Type = A.self) throws -> A
        where A: Authenticatable
    {
        guard let a = try authenticated(A.self) else {
            throw AuthenticationError(
                identifier: "notAuthenticated",
                reason: "\(A.self) has not been authenticated.",
                source: .capture()
            )
        }
        return a
    }
}
*/
