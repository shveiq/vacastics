//
//  extensions.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

internal final class OwnSessionCache: ServiceType {
    /// See `ServiceType`.
    static func makeService(for worker: Container) throws -> OwnSessionCache {
        return .init()
    }
    
    /// Set to `true` when passing through middleware.
    var middlewareFlag: Bool
    
    /// The cached session.
    var session: Session?
    
    /// Creates a new `SessionCache`.
    init(session: Session? = nil) {
        self.session = session
        self.middlewareFlag = false
    }
}

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
