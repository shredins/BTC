//
//  Date+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

extension Date {

    // MARK: - Static Properties
    static let formatter = DateFormatter()

    // MARK: - Public Instance Methods
    func text(format: Format, formatter: DateFormatter = inject()) -> String {
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }

}

extension Date {

    enum Format: String {
        case ddMMMHHmm = "dd MMM 'at' HH:mm"
    }

}
