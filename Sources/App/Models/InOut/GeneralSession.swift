//
//  GeneralSession.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

public struct GeneralSession: Codable {
    
    public var sessionId: String?
    public var lifeTime: Int?
    
    public init(sessionId: String?, lifeTime: Int?) {
        self.sessionId = sessionId
        self.lifeTime = lifeTime
    }
    
}
