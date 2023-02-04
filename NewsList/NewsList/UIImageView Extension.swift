//
//  UIImageView Extension.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    func load(str: String, placeholder: UIImage?, cache: URLCache? = nil, tableView: UITableView) {
        let cache = cache ?? URLCache.shared
        let url = URL(string: str) ?? URL(string: "https://cdn.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej.png")!
        let request = URLRequest(url: url)

        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
//                tableView.reloadData()
            }
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
//                        tableView.reloadData()
                    }

                }
            }).resume()
        }
    }
    
//    public func load(urlString: String, PlaceHolderImage:UIImage) {
//
//        if self.image == nil{
//                self.image = PlaceHolderImage
//        }
//
//        let url = URL(string: urlString)
//
//        URLSession.shared.dataTask(with: url ?? URL(string: "https://cdn.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej.png")!, completionHandler: { (data, response, error) -> Void in
//
//            if error != nil {
//                print(error ?? "No Error")
//                return
//            }
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data!)
//                self.image = image
//            })
//
//        }).resume()
//    }
}
