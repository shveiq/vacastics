//
//  DeviceMiddleware.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

public final class DeviceMiddleware: Middleware {
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        
        guard try req.hasAppSession() else {
            return try next.respond(to: req)
        }
        
        let session = try req.appSession()
       
        let system: GeneralDeviceSystem?
        if req.http.headers.contains(name: "X-System") {
            let x = req.http.headers["X-System"]
            if let systemStr = x.first {
                system = GeneralDeviceSystem.init(rawValue: systemStr)
            } else {
                system = nil
            }
        } else {
            system = nil
        }
        
        let userAgent: String?
        if req.http.headers.contains(name: "User-Agent") {
            let x = req.http.headers["User-Agent"]
            userAgent = x.first
        } else {
            userAgent = nil
        }

        let deviceID: String?
        if req.http.headers.contains(name: "X-Device-ID") {
            let x = req.http.headers["X-Device-ID"]
            deviceID = x.first
        } else {
            deviceID = nil
        }

        let appID: String?
        if req.http.headers.contains(name: "X-App-ID") {
            let x = req.http.headers["X-App-ID"]
            appID = x.first
        } else {
            appID = nil
        }

        let model: String?
        if req.http.headers.contains(name: "X-Device-Model") {
            let x = req.http.headers["X-Device-Model"]
            model = x.first
        } else {
            model = nil
        }
        
        let version: String?
        if req.http.headers.contains(name: "X-App-Version") {
            let x = req.http.headers["X-App-Version"]
            version = x.first
        } else {
            version = nil
        }
        
        let systemVersion: String?
        if req.http.headers.contains(name: "X-System-Version") {
            let x = req.http.headers["X-System-Version"]
            systemVersion = x.first
        } else {
            systemVersion = nil
        }
        
        let device = GeneralDevice.init(system: system, userAgent: userAgent, device: deviceID, appId: appID, model: model, version: version, systemVersion: systemVersion)
        
        if device.checkInSession(session) {
            device.saveInSession(session)
            return try next.respond(to: req)
        }
 
        throw DeviceError(
                identifier: "mistmatchDevice",
                reason: "Invalid parameters device",
                source: .capture()
        )
        
    }
}
