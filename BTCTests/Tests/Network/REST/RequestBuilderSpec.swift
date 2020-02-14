//
//  RequestBuilderSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 14/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable
import BTC

class RequestBuilderSpec: QuickSpec {

    override func spec() {

        describe("RequestBuilder") {

            var sut: RequestBuilderProtocol!
            var urlRequest: URLRequest!

            beforeEach {
                sut = RequestBuilder()
                urlRequest = sut.build(using: MockRequest())
            }

            it("Should have correct path") {
                expect(urlRequest.url!.absoluteString).to(equal("https://google.com/endpoint?param=value"))
            }

            it("Should have httpMethod == 'get'") {
                expect(urlRequest.httpMethod).to(equal("GET"))
            }

            it("Should have correct headers") {
                expect(urlRequest.allHTTPHeaderFields).to(equal(["Header": "Value"]))
            }
        }
    }
}
