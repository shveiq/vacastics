//
//  LoginCommitReply.swift
//  App
//
//  Created by Paweł Szenk on 28/03/2019.
//

import Vapor

struct LoginCommitReply: Codable {
    
    var userID: Int?
    var email: String
    var firstname: String
    var surname: String
    var gravatarURL: String?
    var languageCode: String
    var status: UserStatusType
    
    init(user: User) {
        self.userID = user.userID
        self.email = user.email
        self.firstname = user.firstname
        self.surname = user.surname
        self.gravatarURL = user.gravatarURL
        self.languageCode = user.languageCode
        self.status = user.status
    }
    
    enum CodingKeys: String, CodingKey
    {
        case userID
        case email
        case firstname
        case surname
        case gravatarURL
        case languageCode
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userID = try values.decode(Int.self, forKey: .userID)
        email = try values.decode(String.self, forKey: .email)
        firstname = try values.decode(String.self, forKey: .firstname)
        surname = try values.decode(String.self, forKey: .surname)
        gravatarURL = try values.decodeIfPresent(String.self, forKey: .gravatarURL)
        languageCode = try values.decode(String.self, forKey: .languageCode)
        let statusStr = try values.decode(String.self, forKey: .status)
        status = UserStatusType.init(rawValue: statusStr) ?? .create
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encode(email, forKey: .email)
        try container.encode(firstname, forKey: .firstname)
        try container.encode(surname, forKey: .surname)
        try container.encodeIfPresent(gravatarURL, forKey: .gravatarURL)
        try container.encode(languageCode, forKey: .languageCode)
        try container.encode(status.rawValue, forKey: .status)
    }
    
}

extension LoginCommitReply: Content { }
