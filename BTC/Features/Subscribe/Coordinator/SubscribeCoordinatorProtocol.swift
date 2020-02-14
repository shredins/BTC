//
//  SubscribeCoordinatorProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

protocol SubscribeCoordinatorProtocol: class {

    var root: UIViewController? { get set }

    func perform(route: SubscribeRoute)
    
}
