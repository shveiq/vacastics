//
//  GeneralReply.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

public protocol GenericResponseType {
    associatedtype DataType
    
    var error: Bool? { get set }
    var reason: String? { get set }
    var reply: DataType? { get set }
    var session: GeneralSession? { get set }
    
}

