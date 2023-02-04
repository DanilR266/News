//
//  ViewController.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    let cellId = "cellId"
    private var cellItems: [Article?] = []
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        GetContent.shared.request { [weak self] values in
            DispatchQueue.main.async {
                guard let self=self else { return }
                self.cellItems = values ?? []
                self.tableView.reloadData()
            }
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление новостей...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        GetContent.shared.request { [weak self] values in
            DispatchQueue.main.async {
                guard let self=self else { return }
                self.cellItems = values ?? []
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            
        }
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")!
        let textValue = cellItems[indexPath.row]?.title ?? "Title"
        let imgUrl = cellItems[indexPath.row]?.urlToImage ?? ""
        cell.textLabel?.text = "\(textValue)"
        cell.textLabel?.numberOfLines = 3
        cell.imageView?.image = UIImage(named: "news")
        cell.imageView?.load(str: imgUrl, placeholder: UIImage(named: "news"), cache: URLCache(memoryCapacity: indexPath.row, diskCapacity: indexPath.row, directory: URL(string: imgUrl) ?? URL(string: "https://cdn.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej.png")), tableView: tableView)
//        cell.imageView?.load(urlString: imgUrl, PlaceHolderImage: UIImage(named: "news")!)
        cell.imageView?.contentScaleFactor = 50
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = cellItems[indexPath.row]
        let text = cellItems[indexPath.row]?.title ?? "Title"
        print(text)
        
        
    }
    
    
}

