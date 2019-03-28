import FluentMySQL
import Vapor

public final class User: Model {
    public typealias Database = MySQLDatabase
    public typealias ID = Int
    
    public static var idKey: IDKey = \User.userID
    public static let entity = "user"
    
    var userID: Int?
    var email: String
    var password: String
    var firstname: String
    var surname: String
    var gravatarURL: String?
    var createdAt: Date
    var updatedAt: Date?
    var languageCode: String
    var status: UserStatusType
    
    /// Creates a new user.
    public init(userID: Int? = nil, email: String, password: String, firstname: String, surname: String, gravatarURL: String? = nil, createdAt: Date, updatedAt: Date? = nil, languageCode: String, status: String) {
        self.userID = userID
        self.email = email
        self.password = password
        self.firstname = firstname
        self.surname = surname
        self.gravatarURL = gravatarURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.languageCode = languageCode
        self.status =  UserStatusType.init(rawValue: status) ?? .create
    }

    enum CodingKeys: String, CodingKey
    {
        case userID
        case email
        case password
        case firstname
        case surname
        case gravatarURL
        case createdAt
        case updatedAt
        case languageCode
        case status
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userID = try values.decode(Int.self, forKey: .userID)
        email = try values.decode(String.self, forKey: .email)
        password = try values.decode(String.self, forKey: .password)
        firstname = try values.decode(String.self, forKey: .firstname)
        surname = try values.decode(String.self, forKey: .surname)
        gravatarURL = try values.decodeIfPresent(String.self, forKey: .gravatarURL)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt)
        languageCode = try values.decode(String.self, forKey: .languageCode)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = UserStatusType.init(rawValue: statusStr) ?? .create
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(firstname, forKey: .firstname)
        try container.encode(surname, forKey: .surname)
        try container.encodeIfPresent(gravatarURL, forKey: .gravatarURL)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encode(languageCode, forKey: .languageCode)
        try container.encode(status.rawValue, forKey: .status)
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
    var status: UserApplicationStatusType
    
    /// Creates a new user application.
    init(applicationID: Int? = nil, userID: Int, appcode: String, passcode: String, device: String, model: String, createdAt: Date, status: String) {
        self.applicationID = applicationID
        self.userID = userID
        self.appcode = appcode
        self.passcode = passcode
        self.device = device
        self.model = model
        self.createdAt = createdAt
        self.status = UserApplicationStatusType.init(rawValue: status) ?? .deleted
    }
    
    enum CodingKeys: String, CodingKey
    {
        case applicationID
        case userID
        case appcode
        case passcode
        case device
        case model
        case createdAt
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        applicationID = try values.decode(Int.self, forKey: .applicationID)
        userID = try values.decode(Int.self, forKey: .userID)
        appcode = try values.decode(String.self, forKey: .appcode)
        passcode = try values.decode(String.self, forKey: .passcode)
        device = try values.decode(String.self, forKey: .device)
        model = try values.decode(String.self, forKey: .model)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = UserApplicationStatusType.init(rawValue: statusStr) ?? .deleted
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(applicationID, forKey: .applicationID)
        try container.encode(userID, forKey: .userID)
        try container.encode(appcode, forKey: .appcode)
        try container.encode(passcode, forKey: .passcode)
        try container.encode(device, forKey: .device)
        try container.encode(model, forKey: .model)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(status.rawValue, forKey: .status)
    }
}

extension UserApplication {
    var user: Parent<UserApplication, User> {
        return parent(\UserApplication.userID)
    }
}

extension UserApplication: Content { }
