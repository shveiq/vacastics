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

public struct GeneralRequest<RequestType: GenericRequestType> {
    public let headers: [String: String]
    public let request: RequestType.DataType
    
    public init(headers: [AnyHashable: Any]?, request: RequestType.DataType) {
        var requestHeaders = [String: String]()
        for (key, value) in headers ?? [:] {
            requestHeaders[key as! String] = value as? String ?? ""
        }
        self.headers = requestHeaders
        self.request = request
    }
}
