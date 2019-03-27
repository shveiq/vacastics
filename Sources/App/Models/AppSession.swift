//
//  AppSession.swift
//  App
//
//  Created by Paweł Szenk on 13/03/2019.
//

import FluentSQLite
import Vapor

final class AppSession: Model {
    typealias Database = SQLiteDatabase
    typealias ID = UUID

    public static var idKey: IDKey = \AppSession.sessionID
    static let entity = "user"
    
    var sessionID: UUID?
    var data: Data

    init(id: UUID? = nil, data: Data) {
        self.sessionID = id
        self.data = data
    }
    
}

extension AppSession: Content { }

extension AppSession: SQLiteMigration { }
