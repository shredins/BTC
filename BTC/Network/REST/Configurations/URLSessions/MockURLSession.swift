//
//  MockURLSession.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// I don't want to pass it to Unit Tests target because it may raise a name conflict
internal class MockURLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest, completion: @escaping URLSessionCompletion) -> URLSessionDataTaskProtocol {
        guard let url = Bundle.main.url(forResource: .mockFileName, withExtension: .mockFileExtension),
              let data = try? Data(contentsOf: url) else {
                assertionFailure("Couldn't load mocked json")
                return MockURLSessionDataTask()
        }

        completion(data, MockHTTPURLResponse(url: url), nil)
        return MockURLSessionDataTask()
    }

}

private extension MockURLSession {

    class MockHTTPURLResponse: HTTPURLResponse {

        init?(url: URL) {
            super.init(url: url, statusCode: HTTPStatus.success.rawValue, httpVersion: nil, headerFields: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    struct MockURLSessionDataTask: URLSessionDataTaskProtocol {
        func resume() {}
        func cancel() {}
    }

}

private extension String {
    static let mockPath = "https://google.com"
    static let mockFileName = "Mocked25LiveTrades"
    static let mockFileExtension = "json"
}
