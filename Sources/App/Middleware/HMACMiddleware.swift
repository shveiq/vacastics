//
//  HMACMiddleware.swift
//  App
//
//  Created by Paweł Szenk on 13/03/2019.
//

import Vapor

public final class HMACMiddleware: Middleware {
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        return try next.respond(to: req).map { res in
            var hmac: String?;
            if req.http.headers.contains(name: "X-HMAC") {
                let x = req.http.headers["X-HMAC"]
                hmac = x.first
            }
            
            print("A")
            //TODO!!!
            
            return res
        }
    }
    
}
