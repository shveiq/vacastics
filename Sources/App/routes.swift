import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let registerController = RegisterController()
    router.post("register/init", use: registerController.index)
    router.post(RegisterCommitRequest.self, at: "register/commit", use: registerController.register)
    
    let authController = AuthController()
    router.post("login/init", use: authController.index)
    router.post(LoginCommitRequest.self, at: "login/commit", use: authController.login)
    
    let authRouter = router.grouped(AuthenticateMiddleware.self)
    
    let holidayController = HolidayController()
    authRouter.post("holidays", use: holidayController.index)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    let userController = UserController()
    authRouter.post("organisations", use: userController.departments)
    authRouter.post("organisation", Organisation.parameter, use: userController.department_details)
    authRouter.post(DepartmentCreateRequest.self, at: "organisation/create", use: userController.department_create)
    authRouter.post(DepartmentModifyRequest.self, at: "organisation/update", use: userController.department_modify)
    authRouter.delete("organisation", Organisation.parameter, use: userController.department_delete)

    authRouter.post("departments", use: userController.departments)
    authRouter.post("department", Department.parameter, use: userController.department_details)
    authRouter.post(DepartmentCreateRequest.self, at: "department/create", use: userController.department_create)
    authRouter.post(DepartmentModifyRequest.self, at: "department/update", use: userController.department_modify)
    authRouter.delete("department", Department.parameter, use: userController.department_delete)
    
    authRouter.post("employees", use: userController.departments)
    authRouter.post("employee", Employee.parameter, use: userController.department_details)
    authRouter.post(DepartmentCreateRequest.self, at: "employee/create", use: userController.department_create)
    authRouter.post(DepartmentModifyRequest.self, at: "eployee/update", use: userController.department_modify)
    authRouter.delete("employee", Employee.parameter, use: userController.department_delete)
}
