import FluentMySQL
import Vapor

final class User: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \User.userID
    static let entity = "user"
    
    var userID: Int?
    var email: String
    var password: String
    var firstname: String
    var surname: String
    var gravatarURL: String?
    var createdAt: Date
    var updatedAt: Date?
    var languageCode: String
    var status: String
    
}

extension User: Content { }


final class UserApplication: Model {
    typealias Database = MySQLDatabase
    typealias ID = Int
    
    public static var idKey: IDKey = \UserApplication.applicationID
    static let entity = "application"
    
    var applicationID: Int?
    var userID: Int
    var appcode: String
    var passcode: String
    var device: String
    var model: String
    var createdAt: Date
    var status: String
    
}

extension UserApplication: Content { }
