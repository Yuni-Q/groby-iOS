//
//  ItemListAPI.swift
//  groby
//
//  Created by Daeyun Ethan on 16/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

//itemlisttableviewcontroller
struct ItemListAPI: RequestType {
    static let subURL: String = "participantlist/"

    typealias ResponseType = ItemListJSON

    var requestData: RequestData
    var data: RequestData {
        return requestData
    }

    init(_ requestData: RequestData) {
        self.requestData = requestData
    }
}

struct MainItemListAPI: RequestType {
    typealias ResponseType = MainItemListJSON

    static let subURL: String = "home"

    var requestData: RequestData
    var data: RequestData {
        return requestData
    }

    init(_ requestData: RequestData) {
        self.requestData = requestData
    }
}
