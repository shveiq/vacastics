//
//  GeneralDevice.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

public enum GeneralDeviceSystem: String {
    case web
    case ios
    case android
}

public struct GeneralDevice {
    
    public var system: GeneralDeviceSystem
    public var userAgent: String?
    public var device: String?
    public var appId: String?
    public var model: String?
    public var version: String?
    public var systemVersion: String?
    
    public init(system: GeneralDeviceSystem? = nil, userAgent: String?, device: String?, appId: String?, model: String?, version: String?, systemVersion: String?) {
        self.system = system ?? .web
        self.userAgent = userAgent
        self.device = device
        self.appId = appId
        self.model = model
        self.version = version
        self.systemVersion = systemVersion
    }
    
    public func saveInSession(_ session: Session) {
        session["deviceSystem"] = self.system.rawValue
        if let ua = self.userAgent {
            session["deviceUserAgent"] = ua
        }
        if let dev = self.device {
            session["deviceDeviceID"] = dev
        }
        if let app = self.appId {
            session["deviceAppID"] = app
        }
        if let mod = self.model {
            session["deviceModel"] = mod
        }
        if let ver = self.version {
            session["deviceAppVersion"] = ver
        }
        if let sysVer = self.systemVersion {
            session["deviceSystemVersion"] = sysVer
        }
    }
    
    public func checkInSession(_ session: Session) -> Bool {
        let sessionSystem: GeneralDeviceSystem?
        if let systemStr = session["deviceSystem"] {
            sessionSystem = GeneralDeviceSystem.init(rawValue: systemStr)
        } else {
            sessionSystem = nil
        }
        
        if sessionSystem == nil {
            return true
        }
        
        let sessionUserAgent = session["deviceUserAgent"]
        let sessionDevice = session["deviceDeviceID"]
        let sessionAppId = session["deviceAppID"]
        let sessionModel = session["deviceModel"]
        
        if sessionSystem != self.system ||
            sessionUserAgent != self.userAgent ||
            sessionDevice != self.device ||
            sessionAppId != self.appId ||
            sessionModel != self.model {
            return false
        }
        
        return true
    }
    
}

public struct DeviceError: Debuggable {
    
    public static let readableName = "Device Error"
    
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
        self.stackTrace = DeviceError.makeStackTrace()
    }
    
}
