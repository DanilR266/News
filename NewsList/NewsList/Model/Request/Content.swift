//
//  Content.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import Foundation
import UIKit

class GetContent {
    
    static let shared = GetContent()
    private let today = Date.now
    private let formatter1 = DateFormatter()
    
    func request(completion: @escaping ([Article?]) -> Void) {
        formatter1.dateFormat = "YYYY-MM-dd"
        let url = URL(string:"https://newsapi.org/v2/everything?q=tesla&from=\(formatter1.string(from: today))5&sortBy=publishedAt&apiKey=a6c380b7592e4f2cbad9dd56e02e40da")
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
            do {
                let jsonData = try JSONDecoder().decode(Response.self, from: data)
                
                if jsonData.articles!.count > 20 {
                    let array = Array<Article>(jsonData.articles![0...19])
                    completion(array ?? [])
                }
                else {
                    completion(jsonData.articles ?? [])
                }
            } catch let jsonErr {
                print("failed to decode json:", jsonErr)
            }
        }.resume()
    }
    
}
