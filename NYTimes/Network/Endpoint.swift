//
//  s.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//


import Foundation

struct Endpoint {
    let type: EndPointType
    let path: String
}
extension Endpoint {
    static func getArtical() -> Endpoint {
        return Endpoint(type: .base,
            path: "mostpopular/v2/mostviewed/all-sections/7.json?api-key=H4JizqET7URtdsg0wj5OhTqFnGX4PW6s"
        )
    }
    
}
extension Endpoint {
    var url: URL? {
        switch type {
        case .base:
            let base = "http://api.nytimes.com/svc/"
            return URL(string: base + path)
        }
    }
}

enum EndPointType {
     case base
}

