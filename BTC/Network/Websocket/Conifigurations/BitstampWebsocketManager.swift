//
//  BitstampWebsocketManager.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Starscream

class BitstampWebsocketManager: WebsocketManager {

    // MARK: - Properties
    let decoder: JSONDecoderProtocol = inject()
    let encoder: JSONEncoderProtocol = inject()

    // MARK: - Overridden Properties
    override var secrets: SecretsProtocol {
        BitstampSecrets()
    }

    // MARK: - Public Instance Methods
    /// Used to connect with socket and listening for ack message.
    /// Once ACK is received, listen(completion:) should be called to receive desired messages.
    func send<T: Decodable>(input: Encodable, completion: WebsocketCompletion<T>? = nil) {
        connect { [weak self] didConnect in
            if didConnect {
                self?.write(input: input, completion: completion)
            } else {
                let error = WebsocketManagerError.disconnected
                completion?(.failure(error))
            }
        }
    }

    /// Used to change requested model from ACK to specified T.
    /// Don't call disconnect before this method!
    func listen<T: Decodable>(_ completion: WebsocketCompletion<T>? = nil) {
        let disconnected = {
            let error = WebsocketManagerError.disconnected
            completion?(.failure(error))
        }

        guard let socket = socket else {
            disconnected()
            return
        }

        socket.onDisconnect = { _ in
            disconnected()
        }

        if let completion = completion {
            socket.onText = { [weak self] response in
                self?.handle(response: response, completion)
            }
        }
    }

    // MARK: - Private Instance Methods
    private func write<T: Decodable>(input: Encodable, completion: WebsocketCompletion<T>?) {
        guard let message = input.jsonString(using: encoder) else {
            let error = WebsocketManagerError.encoding
            completion?(.failure(error))
            return
        }

        if let completion = completion {
            socket?.onText = { [weak self] response in
                self?.handle(response: response, completion)
            }
        }

        socket?.write(string: message)
    }

    private func handle<T: Decodable>(response: String, _ completion: WebsocketCompletion<T>) {
        guard let data = response.data(using: .utf8) else {
            let error = WebsocketManagerError.decoding
            completion(.failure(error))
            return
        }

        do {
            let model = try decoder.decode(T.self, from: data)
            completion(.success(model))
        } catch {
            let error = WebsocketManagerError.decoding
            completion(.failure(error))
        }
    }

}
