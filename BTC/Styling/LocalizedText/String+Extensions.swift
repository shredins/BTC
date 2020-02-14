//
//  String+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }

}
