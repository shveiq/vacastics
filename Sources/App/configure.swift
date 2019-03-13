import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(RequestMiddleware())
    middlewares.use(HMACMiddleware())
    middlewares.use(SessionMiddleware())
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    //services.register(RequestMiddleware.self)
    
    // Configure a MySQL database
    //let mysql = MySQLDatabase(config: MySQLDatabaseConfig(hostname: "localhost", port: 3306, username: "domomat_vacdevel", password: "qyfrim-1vuqvi-seQcex", database: "domomat_vacdevel", capabilities: .default, characterSet: .utf8_general_ci, transport: .unverifiedTLS))
    let mysql = MySQLDatabase(config: MySQLDatabaseConfig(hostname: "apki.mobi", port: 3306, username: "domomat_vacdevel", password: "qyfrim-1vuqvi-seQcex", database: "domomat_vacdevel", capabilities: .default, characterSet: .utf8_general_ci, transport: .cleartext))

    // Register the configured MySQL database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    services.register(databases)
    
    User.defaultDatabase = .mysql
    UserApplication.defaultDatabase = .mysql
    Organisation.defaultDatabase = .mysql
    Department.defaultDatabase = .mysql
    Holiday.defaultDatabase = .mysql
    HolidayDuration.defaultDatabase = .mysql
    LeaveType.defaultDatabase = .mysql
    PublicHoliday.defaultDatabase = .mysql
    Employee.defaultDatabase = .mysql
    EmployeeAllowance.defaultDatabase = .mysql
    EmployeeWorkday.defaultDatabase = .mysql
}
