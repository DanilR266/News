//
//  Content.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import Foundation
import UIKit

struct Response: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}


class GetContent {
    
    static let shared = GetContent()
    
    func request(complition: @escaping ([Article?]) -> Void) {
        let url = URL(string:"https://newsapi.org/v2/everything?q=tesla&from=2023-01-04&sortBy=publishedAt&apiKey=a6c380b7592e4f2cbad9dd56e02e40da")
        guard let url = url else { return }
            
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
                
            do {
                let jsonData = try JSONDecoder().decode(Response.self, from: data)
                print("Result")
                complition(jsonData.articles ?? [])
                     
            } catch let jsonErr {
                print("failed to decode json:", jsonErr)
            }
        }.resume()
    }
    
}
