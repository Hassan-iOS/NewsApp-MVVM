//
//  NewsSourceViewModel.swift
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import Foundation
import Moya
import SwiftMessages

class NewsSourceViewModel {
    // of type abservable for observing changes
    let newsProvider = MoyaProvider<APIServiceHandler>()
    var sources = Observable<[Sources]>([])
    
    var sourcesCount: Int {
        return sources.value.count
    }
   
    
    func updateSourceName(for indexPath: Int, isCountrySelected: Bool)->String{
        let source = sources.value[indexPath]
        // implement a logic here
        if isCountrySelected {
            return source.country ?? "No Country Available"
        }else {
          return source.name ?? "No Source Available"
        }
    }
}

extension NewsSourceViewModel {
    
    func fetchData(){
        newsProvider.request(.all) { (result) in
            switch result {
                
            case .success(let response):
                do {
                    let newsSources = try JSONDecoder().decode(NewsSourceModel.self, from: response.data)
                    self.sources.value = newsSources.sources ?? []
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error in getting News: \(error.localizedDescription)")
            }
        }
    }
    
}
