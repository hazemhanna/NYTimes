//
//  ArticalStubs.swift
//  NYTimesTests
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
@testable import NYTimes
class ArticalMockRepo : Repository {
    var networkClient: APIClient
    var cacher: Cacher
    var mockedClient: ArticalMock?
    public init(_ client: ArticalMock = ArticalMock()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Artical"))
    }
    func getMockedAricalList(completion:@escaping ([Result])->()) {
        mockedClient?.readFromFile(fileName: "ArticalStub") { (articalData) in
            completion(articalData)
        }
    }
}
class ArticalMock : APIClient {
func readFromFile(fileName: String ,completion:@escaping ([Result])->()) {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            if let articalData = try? decoder.decode([Result].self, from: data) {
                completion(articalData)
            }
        } catch {

        }
    }
  }
}

