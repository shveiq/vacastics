//
//  GeneralRequest.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

public protocol GenericRequestType {
    associatedtype DataType
    
    var device: GeneralDevice { get set }
    var request: DataType { get set }
    var session: GeneralSession? { get set }
    
}
