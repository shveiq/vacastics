//
//  SessionMiddleware.swift
//  App
//
//  Created by Paweł Szenk on 13/03/2019.
//

import Vapor

public final class SessionMiddleware: Middleware, ServiceType {
    
    public static func makeService(for container: Container) throws -> Self {
        return try .init(sessions: container.make())
    }
    
    public let sessions: Sessions
    
    public init(sessions: Sessions) {
        self.sessions = sessions
    }
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        
        let cache = try req.privateContainer.make(OwnSessionCache.self)
        cache.middlewareFlag = true
        
        var sessionID: String?;
        if req.http.headers.contains(name: "X-Session-ID") {
            let x = req.http.headers["X-Session-ID"]
            sessionID = x.first
        }
        
        if let sessionID = sessionID {
            return try sessions.readSession(sessionID: sessionID).flatMap { session in

                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let calendar = Calendar.current

                if let session = session, let dateStr = session["appSessionTimeLife"], let endDate = dateFormatter.date(from: dateStr) {
                    if endDate < Date() {
                        cache.session = nil
                    } else {
                        if let timeLife = calendar.date(byAdding: .hour, value: 1, to: Date()) {
                            session["appSessionTimeLife"] = dateFormatter.string(from: timeLife)
                        }
                        cache.session = session
                    }
                } else {
                    cache.session = nil
                }
                
                return try next.respond(to: req).flatMap { res in
                    return try self.modifySession(to: res, for: req, cache: cache)
                }
            }
        } else {
            return try next.respond(to: req).flatMap { res in
                return try self.modifySession(to: res, for: req, cache: cache)
            }
        }
        
    }
    
    private func modifySession(to res: Response, for req: Request, cache: OwnSessionCache) throws -> Future<Response> {
     
        if let session = cache.session {
            let createOrUpdate: Future<Void>
            if session.id == nil {
                createOrUpdate = try sessions.createSession(session)
            } else {
                createOrUpdate = try sessions.updateSession(session)
            }
            
            return createOrUpdate.map {
                if let id = session.id {
                    res.http.headers.add(name: "X-Session-ID", value: id)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    
                    if let dateStr = session["appSessionTimeLife"], let endDate = dateFormatter.date(from: dateStr) {
                        let diffDate = Int(endDate.timeIntervalSinceNow)
                        res.http.headers.add(name: "X-Session-LifeTime", value: String(format: "%d", diffDate))
                    }
                    
                }
                return res
            }
        } else {
            var sessionID: String?;
            if req.http.headers.contains(name: "X-Session-ID") {
                let x = req.http.headers["X-Session-ID"]
                sessionID = x.first
            }
            if let sessionID = sessionID {
                return try self.sessions.destroySession(sessionID: sessionID).map {
                    return res
                }
            } else {
                return req.eventLoop.newSucceededFuture(result: res)
            }
        }
    }
    
}
