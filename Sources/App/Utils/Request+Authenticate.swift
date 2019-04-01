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
    
    var isLoaded: Bool

    var user: User?
    
    /// Creates a new `SessionCache`.
    init(user: User? = nil) {
        self.isLoaded = false
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

        guard try hasAppSession() else {
            cache.isLoaded = false
            cache.user = nil
            return
        }
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        let session = try appSession()
        session["authenticateUser"] = data.base64EncodedString()
        
        cache.user = user
        cache.isLoaded = true
    }
    
    public func authenticated() throws -> User?
    {
        let cache = try privateContainer.make(AuthenticateCache.self)
        if cache.isLoaded {
            return cache.user
        } else {
            guard try hasAppSession() else {
                return nil
            }
            let session = try appSession()
            guard let dataStr = session["authenticateUser"],
                  let dataBase = Data(base64Encoded: dataStr) else {
                    return nil
            }
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: dataBase)
            cache.user = user
            cache.isLoaded = true
            return cache.user
        }
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
