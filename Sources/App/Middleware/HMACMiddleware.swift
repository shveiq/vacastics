//
//  HMACMiddleware.swift
//  App
//
//  Created by Paweł Szenk on 13/03/2019.
//

import Vapor
import Crypto

public final class HMACMiddleware: Middleware {
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {

        var hmac: String?;
        if req.http.headers.contains(name: "X-HMAC") {
            let x = req.http.headers["X-HMAC"]
            hmac = x.first
        }
        
        guard hmac != nil else {
            return try next.respond(to: req)
        }
        
        let bodyData = req.http.body.data ?? Data()
        
        var sessionID: String?;
        if req.http.headers.contains(name: "X-Session-ID") {
            let x = req.http.headers["X-Session-ID"]
            sessionID = x.first
        }
        let sessionData = sessionID?.data(using: .utf8) ?? Data()
        
        let session = try req.appSession()
        let keyStr = session["loginToken"] ?? ""
        
        let data = bodyData + sessionData
        let key = Data(base64Encoded: keyStr) ?? Data()
        
        guard key.count == 32, data.count > 0 else {
            return try next.respond(to: req)
        }

        print(String(data: data, encoding: .utf8))
        print(key.hexEncodedString())

        let computeHMAC = try HMAC.SHA256.authenticate(data, key: key)

        guard let localHmac = hmac, localHmac == computeHMAC.hexEncodedString() else {
            throw AuthenticationError(
                identifier: "notAuthenticated",
                reason: "Request with invalid HMAC.",
                source: .capture()
            )
        }
        
        return try next.respond(to: req).map { res in

            print(res.http.body)
            
            return res
        }
    }
    
}
