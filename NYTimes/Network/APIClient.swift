//
//  a.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//



import Foundation
import Alamofire


protocol APIClient {
    func makeRequest(withRequest: URLRequest, completion: @escaping JSONTaskCompletionHandler)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (RequestResult<Decodable, RequestError>) -> Void
    func makeRequest(withRequest: URLRequest, completion: @escaping JSONTaskCompletionHandler){
        Alamofire.request(withRequest).responseJSON(completionHandler: {
            (response) in
            if let error = response.error {
                print(error)
                completion(.failure(.connectionError))
            } else {
                print(response)
                if let code = response.response?.statusCode {
                    let result = response.result
                    switch code {
                    case 200:
                        //completion(.success(responseJson))
                        if result.isSuccess {
                            completion(.success(nil))
                        } else {
                            completion(.failure(.unknownError))
                        }
                    case 400 ... 499:
                        completion(.failure(.authorizationError))
                    case 500 ... 599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.unknownError))
                        break
                    }
                }
            }
        })
    }
    
    func makeRequest<T: Decodable>(withRequest: URLRequest, decodingType:T.Type,completion: @escaping JSONTaskCompletionHandler) {

        Alamofire.request(withRequest).responseJSON(completionHandler: {
            (response) in
            if let error = response.error {
                print(error)
                completion(.failure(.connectionError))
            } else if let data = response.data {
                print(response)
                if let code = response.response?.statusCode {
                    switch code {
                    case 200:
                        //                            completion(.success(responseJson))
                        self.decodeJsonResponse(decodingType: decodingType, jsonObject: data, completion: completion)
                    case 400 ... 499:
                        completion(.failure(.authorizationError))
                    case 500 ... 599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.unknownError))
                        break
                    }
                }
            }
        })
    }
    func decodeJsonResponse<T: Decodable>(decodingType:T.Type,jsonObject: Data, completion: @escaping JSONTaskCompletionHandler){
        DispatchQueue.main.async {

            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: jsonObject)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
}
