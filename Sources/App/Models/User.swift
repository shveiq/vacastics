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
    init(userID: Int? = nil, email: String, password: String, firstname: String, surname: String, gravatarURL: String? = nil, createdAt: Date, updatedAt: Date? = nil, languageCode: String, status: String) {
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

extension User {
    var organizations: Children<User, Organisation> {
        return children(\Organisation.bossID)
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
    
    /// Creates a new user application.
    init(applicationID: Int? = nil, userID: Int, appcode: String, passcode: String, device: String, model: String, createdAt: Date, status: String) {
        self.applicationID = applicationID
        self.userID = userID
        self.appcode = appcode
        self.passcode = passcode
        self.device = device
        self.model = model
        self.createdAt = createdAt
        self.status = status
    }
    
}

extension UserApplication {
    var user: Parent<UserApplication, User> {
        return parent(\UserApplication.userID)
    }
}

extension UserApplication: Content { }
