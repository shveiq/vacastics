//
//  GeneralReply.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

public protocol GenericResponseType {
    associatedtype DataType
    
    var error: Bool? { get }
    var reason: String? { get }
    var reply: DataType { get }
    var session: GeneralSession? { get }
    
}

