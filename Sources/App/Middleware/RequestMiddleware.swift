//
//  RequestMiddleware.swift
//  App
//
//  Created by Paweł Szenk on 13/03/2019.
//
import Vapor

public final class RequestMiddleware: Middleware {
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        return try next.respond(to: req).map { res in
            var requestID: String;
            if req.http.headers.contains(name: "X-Request-ID") {
                let x = req.http.headers["X-Request-ID"]
                requestID = x.first ?? UUID().uuidString
            } else {
                requestID = UUID().uuidString
            }
            res.http.headers.replaceOrAdd(name: "X-Request-ID", value: requestID)
            return res
        }
    }
     
}
