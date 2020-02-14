//
//  QuickConfiguration.swift
//  BTCTests
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Quick

@testable import BTC

class BTCQuickConfiguration: QuickConfiguration {

    override class func configure(_ configuration: Configuration!) {
        configuration.beforeEach {
            DependencyInjection.container.reset()
        }
    }

}
