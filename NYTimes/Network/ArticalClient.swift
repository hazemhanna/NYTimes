//
//  ss.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation


import Foundation

class ArticalClient : APIClient {
    func getArticalesList( completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) {
        guard let url = Endpoint.getArtical().url else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //urlRequest.httpMethod = HTTPMethod.post.rawValue
        makeRequest(withRequest: urlRequest ,decodingType: ArticalesModelJSON.self) { (result) in
            completion(result)
        }
    }
}
