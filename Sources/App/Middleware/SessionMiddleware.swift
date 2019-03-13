//
//  SessionMiddleware.swift
//  App
//
//  Created by Paweł Szenk on 13/03/2019.
//

import Vapor

public final class SessionMiddleware: Middleware {
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        return try next.respond(to: req).map { res in
            var sessionID: String?;
            if req.http.headers.contains(name: "X-Session-ID") {
                let x = req.http.headers["X-Session-ID"]
                sessionID = x.first
            }
            
            print("B")

            //TODO!!!
            
            return res
        }
    }
    
}
