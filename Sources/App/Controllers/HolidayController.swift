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

}
