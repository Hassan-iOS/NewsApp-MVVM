//
//  ApiService.swift
//  MVVM paractice
//
//  Created by Hassan Mostafa on 7/30/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import Foundation
import Alamofire
import Moya

let yourApiKey = "38da3210dffe490a881856e92b7ae826"
enum APIServiceHandler {
    case all
    case filterNews(country: String)
    case filternews(source: String)
}
extension APIServiceHandler: TargetType {
    
    var baseURL: URL {
        switch self {
    
        case .filterNews(let country):
            guard let filterNewsWithCountryUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(yourApiKey)") else { fatalError("Error in Url") }
            return filterNewsWithCountryUrl
        case .filternews(let source):
            guard let filterNewsWithSourceUrl = URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=\(yourApiKey)") else { fatalError("Error in Url")
            }
            return filterNewsWithSourceUrl
        case .all:
            guard let allUrl = URL(string: "https://newsapi.org/v2/sources?&apiKey=\(yourApiKey)") else { fatalError("Error in Url") }
            return allUrl
        }
    }
    
    var path: String {
        switch self {
        case .filterNews( _):
            return ""
        case .filternews( _):
            return ""
        case .all:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
