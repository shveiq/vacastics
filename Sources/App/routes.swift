import Vapor

struct MySQLVersion: Codable {
    let version: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get { req in
        return "It works!"
    }
    
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("sql") { req in
        return req.withPooledConnection(to: .mysql) { conn in
            return conn.raw("SELECT @@version as version")
                .all(decoding: MySQLVersion.self)
        }.map { rows in
            return rows[0].version
        }
    }
    
    router.get("sql2") { req in
        return User.query(on: req).all()
    }
    
    // Example of configuring a controller
    let holidayController = HolidayController()
    router.post("holidays", use: holidayController.index)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}
