//
//  GeneralDevice.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

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
    
    enum CodingKeys: String, CodingKey
    {
        case system
        case userAgent = "user_agent"
        case device
        case appId = "app_id"
        case model
        case version
        case systemVersion = "system_version"
    }
    
}

extension GeneralDevice: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let systemStr = try values.decode(String.self, forKey: .system)
        system = GeneralDeviceSystem.init(rawValue: systemStr) ?? .web

        if system == .web {
            userAgent = try values.decode(String.self, forKey: .userAgent)
        } else {
            appId = try values.decodeIfPresent(String.self, forKey: .appId)
            device = try values.decode(String.self, forKey: .device)
            model = try values.decode(String.self, forKey: .model)
            version = try values.decode(String.self, forKey: .version)
            systemVersion = try values.decode(String.self, forKey: .systemVersion)
        }
    }
    
}

extension GeneralDevice: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(system.rawValue, forKey: .system)
        try container.encodeIfPresent(userAgent, forKey: .userAgent)
        try container.encodeIfPresent(appId, forKey: .appId)
        try container.encodeIfPresent(device, forKey: .device)
        try container.encodeIfPresent(model, forKey: .model)
        try container.encodeIfPresent(version, forKey: .version)
        try container.encodeIfPresent(systemVersion, forKey: .systemVersion)
    }
    
}
