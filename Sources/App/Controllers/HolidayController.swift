//
//  HolidayController.swift
//  App
//
//  Created by Pawel Szenk on 12/03/2019.
//

import Vapor

final class HolidayController {

    func index(_ req: Request) throws -> Future<HolidayReply> {
        return try req.content.decode(HolidayRequest.self).map { _ in
            let item = HolidayItemReply(id: 1, startDate: Date(), startType: "MORNING")
            return HolidayReply(holidays: [item], totalRecords: 1, pageNumber: 1)
        }
    }
    
    func index2(_ req:Request, _ holidayRequest: HolidayRequest) throws -> Future<HolidayReply> {
        
        print(holidayRequest)
        throw VaporError.init(identifier: "tatatat", reason: "trururur")
        
        let item = HolidayItemReply(id: 1, startDate: Date(), startType: "MORNING")
        let reply = HolidayReply(holidays: [item], totalRecords: 1, pageNumber: 1)
        return req.next().newSucceededFuture(result: reply)
    }

}
