//
//  SourceObserverDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol SourceObserverDelegate: class {
    func sourceObserver(_ observer: SourceObserverProtocol, didDetectSourceFailure source: SourceProtocol)
}
