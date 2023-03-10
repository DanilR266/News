//
//  ViewController.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    let cellId = "cellId"
    private var cellItems: [Article?] = []
    private var dict: Dictionary<String, Int> = [:]
    private let refreshControl = UIRefreshControl()
    private let refrechConnection = UIRefreshControl()
    private let dictViews = Views()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NetworkMonitor.shared.isConnect {
            setUpTableView()
            view.backgroundColor = .white
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
            GetContent.shared.request { [weak self] values in
                DispatchQueue.main.async {
                    guard let self=self else { return }
                    self.cellItems = values ?? []
                    var strs: Array<String> = []
                    for i in values {
                        strs.append(i!.title!)
                    }
                    self.dict = Views().setNumberOfViews(self.dictViews.getDict() ?? [:], strs: strs)
                    self.tableView.reloadData()
                }
            }
            refreshControl.attributedTitle = NSAttributedString(string: "Обновление новостей...")
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            tableView.addSubview(refreshControl)
        }
        else {
            view.backgroundColor = .white
            internetDisconnect()
        }

    }
    
    @objc func refresh(_ sender: AnyObject) {
        GetContent.shared.request { [weak self] values in
            DispatchQueue.main.async {
                guard let self=self else { return }
                self.cellItems = values ?? []
                self.refreshControl.endRefreshing()
                var strs: Array<String> = []
                for i in values {
                    strs.append(i!.title!)
                }
                self.dict = Views().setNumberOfViews(self.dictViews.getDict() ?? [:], strs: strs)
                self.tableView.reloadData()
            }
        }
    }
    
    func internetDisconnect() {
        lazy var source: UILabel = {
            let source = UILabel()
            source.text = "No internet connection"
            source.font = .systemFont(ofSize: 32, weight: .regular)
            source.textAlignment = .center
            return source
        }()
        view.addSubview(source)
        source.translatesAutoresizingMaskIntoConstraints = false
        source.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        source.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
        self.tableView.estimatedRowHeight = 80 // примерная высота ячейки
        self.tableView.rowHeight = UITableView.automaticDimension
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")!
        let textValue = cellItems[indexPath.row]?.title ?? "Title"
        let imgUrl = cellItems[indexPath.row]?.urlToImage ?? ""
        cell.textLabel?.text = "Views: \(dictViews.getDict()!["\(textValue)"]!). \(textValue)"
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named: "news")
        cell.imageView?.load(str: imgUrl, placeholder: UIImage(named: "news")!, cache: nil, tableView: tableView)
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cell.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = "\(cellItems[indexPath.row]?.title ?? "Title is empty.")"
        dictViews.increaseDict(str: text)
        let imageC = tableView.cellForRow(at: indexPath)?.imageView?.image
        let description = cellItems[indexPath.row]?.description ?? " Description is empty."
        let date = cellItems[indexPath.row]?.publishedAt ?? "Date is empty."
        let author = cellItems[indexPath.row]?.source?.name ?? "Source is empty."
        let link = cellItems[indexPath.row]?.url ?? "Url is empty."
        present(CellController(label: text, image: imageC!, description: description, date: date, author: author, link: link), animated: true)
        tableView.reloadData()
    }
    
}

