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
    
    /// Creates a new user.
    init(userID: Int? = nil, email: String, password: String, firstname: String, surname: String, gravatarURL: String?, createdAt: Date, updatedAt: Date?, languageCode: String, status: String) {
        self.userID = userID
        self.email = email
        self.password = password
        self.firstname = firstname
        self.surname = surname
        self.gravatarURL = gravatarURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.languageCode = languageCode
        self.status = status
    }
    
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
