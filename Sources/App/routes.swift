import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let authController = AuthController()
    router.post("login/init", use: authController.index)
    router.post(LoginCommitRequest.self, at: "login/commit", use: authController.login)
    
    router.get("session") { req -> String in
                let session = try req.appSession()
                session["name"] = "Vapor"
                return "Session set"
    }
    
    let holidayController = HolidayController()
    router.post("holidays", use: holidayController.index)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}
