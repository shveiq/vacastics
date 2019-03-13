import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    
    
    let holidayController = HolidayController()
    router.post(HolidayRequest.self, at: "holidays2", use: holidayController.index2)    
    router.post("holidays", use: holidayController.index)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}
