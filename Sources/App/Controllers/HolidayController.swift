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
            let reply = HolidayReplyData(holidays: [item], totalRecords: 1, pageNumber: 1)
            return HolidayReply(error: nil, reason: nil, reply: reply, session: nil)
        }
    }
    
    func index2(_ req:Request, _ holidayRequest: HolidayRequest) throws -> Future<HolidayReply> {
        
        print(holidayRequest)
        //throw VaporError.init(identifier: "tatatat", reason: "trururur")
        
        let item = HolidayItemReply(id: 1, startDate: Date(), startType: "MORNING")
        let replyData = HolidayReplyData(holidays: [item], totalRecords: 1, pageNumber: 1)
        let reply = HolidayReply(error: nil, reason: nil, reply: replyData, session: nil)
        return req.next().newSucceededFuture(result: reply)
    }

}
