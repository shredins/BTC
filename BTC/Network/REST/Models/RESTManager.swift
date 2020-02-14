//
//  RESTManager.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// I've provided general implementation of it because each REST Api has it's own rules e.g. how errors are handled etc.
class RESTManager: RESTManagerProtocol {

    // MARK: - Properties
    let uiQueue: DispatchQueue
    let session: URLSessionProtocol = inject()
    let decoder: JSONDecoderProtocol = inject()
    let requestBuilder: RequestBuilderProtocol = inject()

    // MARK: - Observed Properties
    private var currentDataTask: URLSessionDataTaskProtocol? {
        willSet {
            // Ensures that request won't be duplicated e.g. when user taps button fast
            currentDataTask?.cancel()
        }
    }

    // MARK: - Inits
    init(uiQueue: DispatchQueue = .main) {
        self.uiQueue = uiQueue
    }

    // MARK: - Public Instance Methods
    @discardableResult func call<T: Decodable>(input: RequestProtocol,
                                               _ completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTaskProtocol? {

        let request = requestBuilder.build(using: input)

        currentDataTask = session.dataTask(with: request) { [weak self] data, response, error in
            self?.handle(data: data, response: response, error: error, completion)
        }

        currentDataTask?.resume()
        return currentDataTask
    }

    // MARK: - Private Instance Methods
    private func handle<T: Decodable>(data: Data?,
                                      response: URLResponse?,
                                      error: Error?,
                                      _ completion: @escaping (Result<T, Error>) -> Void) {

        guard let response = response as? HTTPURLResponse else {
            let finalError = error ?? RESTManagerError.noResponse
            send(result: .failure(finalError), completion)
            return
        }

        guard HTTPStatus(rawValue: response.statusCode) == .success else {
            let error = RESTManagerError.statusCode
            send(result: .failure(error), completion)
            return
        }

        do {
            let response: T = try decode(data: data)
            send(result: .success(response), completion)
        } catch {
            send(result: .failure(error), completion)
        }
    }

    private func send<T: Decodable>(result: Result<T, Error>, _ completion: @escaping (Result<T, Error>) -> Void) {
        uiQueue.async {
            completion(result)
        }
    }

    private func decode<T: Decodable>(data: Data?) throws -> T {
        let data = data ?? Data()

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw RESTManagerError.decoding
        }
    }

}
