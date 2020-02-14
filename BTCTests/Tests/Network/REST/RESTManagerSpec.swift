//
//  RESTManagerSpec.swift
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

class RESTManagerSpec: QuickSpec {

    override func spec() {

        describe("RESTManager") {

            var sut: RESTManagerProtocol!
            var queue: DispatchQueue!
            var session: MockURLSession!

            beforeEach {
                session = MockURLSession()
                queue = DispatchQueue(label: "RESTManagerSpec", qos: .userInteractive)

                DependencyInjection.container.register { session as URLSessionProtocol }
                DependencyInjection.container.register { RequestBuilder() as RequestBuilderProtocol }
                DependencyInjection.container.register { WebsocketJSONDecoder() as JSONDecoderProtocol }

                sut = RESTManager(uiQueue: queue)
            }

            it("Should cancel previously performed request") {
                let dataTask = sut.call(input: MockRequest()) { (result: Result<[Trade], Error>) in } as! MockURLSessionDataTask
                _ = sut.call(input: MockRequest()) { (result: Result<[Trade], Error>) in }
                expect(dataTask.didCallCancel).to(beTrue())
            }

            it("Should call resume of URLSessionDataTask") {
                let dataTask = sut.call(input: MockRequest()) { (result: Result<[Trade], Error>) in } as! MockURLSessionDataTask
                expect(dataTask.didCallResume).to(beTrue())
            }

            it("Should handle success response") {
                var response: [Trade] = []

                session.operationToPerform = .success

                _ = sut.call(input: MockRequest()) { (result: Result<[Trade], Error>) in
                    switch result {
                    case .success(let trades):
                        response = trades
                    default:
                        fail()
                    }
                }

                queue.sync {}

                expect(response).to(haveCount(25))
            }

            it("Should handle wrongStatusCode failure") {
                var failureError: RESTManagerError?

                session.operationToPerform = .wrongStatusCode

                _ = sut.call(input: MockRequest()) { (result: Result<[Trade], Error>) in
                    switch result {
                    case .failure(let error):
                        failureError = error as? RESTManagerError
                    default:
                        fail()
                    }
                }

                queue.sync {}

                expect(failureError).to(equal(.statusCode))
            }

            it("Should handle noResponse failure") {
                var failureError: RESTManagerError?

                session.operationToPerform = .noResponse

                _ = sut.call(input: MockRequest()) { (result: Result<[Trade], Error>) in
                    switch result {
                    case .failure(let error):
                        failureError = error as? RESTManagerError
                    default:
                        fail()
                    }
                }

                queue.sync {}

                expect(failureError).to(equal(.noResponse))
            }
        }
    }
}

private extension RESTManagerSpec {

    class MockURLSession: URLSessionProtocol {

        // MARK: - Types
        enum Operation {
            case success
            case wrongStatusCode
            case noResponse
        }

        // MARK: - Mock Properties
        var operationToPerform: Operation = .success

        // MARK: - Implementation
        func dataTask(with request: URLRequest,
                      completion: @escaping URLSessionCompletion) -> URLSessionDataTaskProtocol {

            guard let url = Bundle.main.url(forResource: .mockFileName, withExtension: .mockFileExtension),
                  let data = try? Data(contentsOf: url) else {
                    fatalError()
            }

            switch operationToPerform {
            case .success:
                let httpResponse = HTTPURLResponse(url: url,
                                                   statusCode: HTTPStatus.success.rawValue,
                                                   httpVersion: nil,
                                                   headerFields: request.allHTTPHeaderFields)
                completion(data, httpResponse, nil)
            case .wrongStatusCode:
                let httpResponse = HTTPURLResponse(url: url,
                                                   statusCode: HTTPStatus.badRequest.rawValue,
                                                   httpVersion: nil,
                                                   headerFields: request.allHTTPHeaderFields)
                completion(nil, httpResponse, nil)
            case .noResponse:
                completion(nil, nil, RESTManagerError.noResponse)
            }

            return MockURLSessionDataTask()
        }

    }

    class MockURLSessionDataTask: URLSessionDataTaskProtocol {

        // MARK: - Mock Properties
        var didCallResume = false
        var didCallCancel = false

        // MARK: - Implementation
        func resume() {
            didCallResume = true
        }

        func cancel() {
            didCallCancel = true
        }

    }

}

private extension String {
    static let mockPath = "https://google.com"
    static let mockFileName = "Mocked25LiveTrades"
    static let mockFileExtension = "json"
}
