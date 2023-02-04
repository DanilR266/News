//
//  CellController.swift
//  NewsList
//
//  Created by Данила on 04.02.2023.
//

import Foundation
import UIKit

class CellController: UIViewController {
    
    let label: String
    
    init(label: String) {
        self.label = label
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var labelS: UILabel = {
        let lbl = UILabel()
        lbl.text = label
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setUpLbl()
    }
    
    private func setUpLbl() {
        view.addSubview(labelS)
        labelS.translatesAutoresizingMaskIntoConstraints = false
        labelS.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        labelS.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
