//
//  GeneralReply.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Foundation

public enum GeneralResult<ResultType> {
    case success(ResultType)
    case failure(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var value: ResultType? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error;
        }
    }
}

public enum GenericError: Error {
    case network(statusCode: Int, data: Data?)
    case parse(statusCode: Int, data: Data?)
    case business(statusCode: Int, data: Data?)
}

public protocol GenericResponseType {
    associatedtype DataType
    
    var error: Error? { get }
    var reply: DataType? { get }
    var session: GeneralSession? { get }
}

public struct GeneralReply<ResponseType: GenericResponseType> {
    public let headers: [String: String]
    public let statusCode: Int
    public let result: GeneralResult<ResponseType.DataType>
    
    public init(headers: [AnyHashable: Any]?, statusCode: Int?, result: GeneralResult<ResponseType.DataType>) {
        var replyHeaders = [String: String]()
        for (key, value) in headers ?? [:] {
            replyHeaders[key as! String] = value as? String ?? ""
        }
        self.headers = replyHeaders
        self.statusCode = statusCode ?? -1
        self.result = result
    }
}
