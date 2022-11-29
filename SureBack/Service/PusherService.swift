//
//  PusherService.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 23/11/22.
//

import Foundation
import PusherSwift

private class AuthRequestBuilder: AuthRequestBuilderProtocol {
    private var accessToken: String {
        do {
            return try KeychainHelper.standard.read(key: .accessToken)
        } catch {
            print(error)
            return "noToken"
        }
    }

    func requestFor(socketID: String, channelName: String) -> URLRequest? {
        var request = URLRequest(url: URL(string: Endpoints.broadcastingAuth.url)!)
        request.httpMethod = "POST"
        request.httpBody = "socket_id=\(socketID)&channel_name=\(channelName)".data(using: .utf8)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
}

final class PusherService {
    private let pusher: Pusher
    private let channel: PusherChannel
    private let eventName: String

    init(delegate: PusherDelegate, channelName: String, eventName: String) {
        self.eventName = eventName

        let options = PusherClientOptions(
            authMethod: .authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),
            host: .cluster(Bundle.main.object(forInfoDictionaryKey: "PUSHER_APP_CLUSTER") as? String ?? "")
        )

        pusher = Pusher(
            key: Bundle.main.object(forInfoDictionaryKey: "PUSHER_APP_KEY") as? String ?? "",
            options: options
        )

        pusher.delegate = delegate

        channel = pusher.subscribe("private-\(channelName)")

        pusher.connect()
    }

    func didReceive<T: Codable>(of type: T.Type, completion: @escaping (T) -> Void) {
        // bind a callback to handle an event
        channel.bind(eventName: eventName, eventCallback: { (event: PusherEvent) in
            if let data = event.data {
                // you can parse the data as necessary
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data.data(using: .utf8)!)
                    completion(decodedData)
                } catch let error as NSError {
                    print(error.description)
                }
            }
        })
    }

    func didReceive(completion: @escaping (String) -> Void) {
        // bind a callback to handle an event
        channel.bind(eventName: eventName, eventCallback: { (event: PusherEvent) in
            if let data = event.data {
                completion(data)
            }
        })
    }

    func disconnect() {
        pusher.disconnect()
    }

    deinit {
        disconnect()
    }
}
