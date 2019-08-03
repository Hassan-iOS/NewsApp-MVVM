//
//  FilterViewModel.swift
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import Foundation
import Moya

class FilterViewModel {
    
    let newsProvider = MoyaProvider<APIServiceHandler>()
    var filteredBySources = Observable<[Articles]>([])
    var filteredByCountry = Observable<[Articles]>([])
    
}
extension FilterViewModel {
    func fetchFilteredNewsBySorce(source: String) {
        newsProvider.request(.filternews(source: source)) { (result) in
            switch result {
                
            case .success(let response):
                do {
                    let newsSources = try JSONDecoder().decode(NewsDataModel.self, from: response.data)
                    self.filteredBySources.value = newsSources.articles ?? []
                    
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error in getting News: \(error.localizedDescription)")
            }
        }
    }
}
extension FilterViewModel {
    func fetchFilteredNewsCountry(country: String) {
        newsProvider.request(.filterNews(country: country)) { (result) in
            switch result {
                
            case .success(let response):
                do {
                    let newsByCountry = try JSONDecoder().decode(NewsDataModel.self, from: response.data)
                    self.filteredByCountry.value = newsByCountry.articles ?? []
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error in getting News: \(error.localizedDescription)")
            }
        }
    }
}
