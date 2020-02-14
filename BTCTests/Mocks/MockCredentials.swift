//
//  MockSecrets.swift
//  BTCTests
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

@testable import BTC

class MockSecrets: SecretsProtocol {
    let apiUrl: URL = URL(string: "https://google.com")!
}
