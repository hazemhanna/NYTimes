//
//  NetworkClient.swift
//  NYTimes
//
//  Created by Adel Aref on 10/12/2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
open class NetworkClient: APIClient {
}
func makeRequest(url: URL, parameters: [String: Any]?, type: HTTPMethod) -> URLRequest {
    var urlRequest = URLRequest(url: url, timeoutInterval: 10)
    do {
        urlRequest.httpMethod = type.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            urlRequest.httpBody   = try JSONSerialization.data(withJSONObject: parameters)
        }
        return urlRequest
    } catch let error {
        print("Error : \(error.localizedDescription)")
    }
    return urlRequest
}
