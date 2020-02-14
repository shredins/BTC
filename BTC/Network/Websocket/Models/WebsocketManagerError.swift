//
//  WebsocketManagerError.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

enum WebsocketManagerError: Error {
    case disconnected
    case decoding
    case encoding
}
