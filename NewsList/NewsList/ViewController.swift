//
//  ViewController.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellid"
    var cellItems: [CellItems] = [CellItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let currentLastItem = cellItems[indexPath.row]
        cell.textLabel?.text = currentLastItem.label.text!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
     }
    
    func createProductArray() {
        cellItems.append(CellItems(label: UILabel(), image: <#T##UIImage#>, count: <#T##UILabel#>))
        }


}

