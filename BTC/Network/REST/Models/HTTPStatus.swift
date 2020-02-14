//
//  HTTPStatus.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// In this case REST should be mocked so I've provided just main status.
// Obviously in application cases would be extended e.g. unauthorized, internalServerError etc.
enum HTTPStatus: Int {
    case success = 200
    case badRequest = 400
}
