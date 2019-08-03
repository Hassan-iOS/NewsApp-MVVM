//
//  MainViewModel.swift
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import Foundation
import UIKit
import Moya

class ArticleViewModel {
    // of type abservable for observing changes
    let newsProvider = MoyaProvider<APIServiceHandler>()
    var articles = Observable<[Articles]>([])
    
    var articleCount: Int {
        return articles.value.count
    }
    
    func updateTitle(for indexPath: Int)->String{
        let article = articles.value[indexPath]
        // implement a logic here
        return article.title ?? ""
    }
    func updateSource(for indexPath: Int)->String{
        let article = articles.value[indexPath]
        // implement a logic here
        return article.source?.name ?? ""
    }
    func updateImage(for indexPath: Int)->String {
        let article = articles.value[indexPath]
        return article.urlToImage ?? ""
    }
    func updateContent(for indexPath: Int)-> String {
        let article = articles.value[indexPath]
        return article.content ?? ""
    }
    func updateDate(for indexPath: Int)-> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let article = articles.value[indexPath]
        if let date = dateFormatter.date(from: article.publishedAt ?? "") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
// MARK:- Network calls
extension ArticleViewModel {
    
    func fetchData(){
        newsProvider.request(.filterNews(country: "us")) { (result) in
            switch result {
                
            case .success(let response):
                do {
                    let news = try JSONDecoder().decode(NewsDataModel.self, from: response.data)
                    self.articles.value = news.articles!
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error in getting News: \(error.localizedDescription)")
            }
        }
    }
}
