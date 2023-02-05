//
//  CellController.swift
//  NewsList
//
//  Created by Данила on 04.02.2023.
//

import Foundation
import UIKit

class CellController: UIViewController {
    
    let labelController: String
    let imageCell: UIImage
    let descriptionCell: String
    let datePublish: String
    let author: String
    let link: String
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    
    init(label: String, image: UIImage, description: String, date: String, author: String, link: String) {
        self.labelController = label
        self.imageCell = image
        self.descriptionCell = description
        self.datePublish = date
        self.author = author
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var labelS: UILabel = {
        let lbl = UILabel()
        lbl.text = "\(labelController)"
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.numberOfLines = 0
        lbl.setNeedsDisplay()
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var subLabel: UILabel = {
        let sub = UILabel()
        sub.text = descriptionCell
        sub.font = .systemFont(ofSize: 16, weight: .regular)
        sub.numberOfLines = 0
        sub.setNeedsDisplay()
        sub.textAlignment = .center
        return sub
    }()
    
    lazy var dateAT: UILabel = {
        let date = UILabel()
        date.text = "Publication date: \(datePublish)"
        date.font = .systemFont(ofSize: 16, weight: .regular)
        date.textAlignment = .left
        return date
    }()
    
    lazy var source: UILabel = {
        let source = UILabel()
        source.text = "Source: \(author)"
        source.font = .systemFont(ofSize: 16, weight: .regular)
        source.textAlignment = .left
        return source
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("\(link)", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        btn.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.image = imageCell
        img.sizeToFit()
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 4000)
        setUpScrollView()
    }
    
    @objc func pressed(_ sender: UIButton) {
        present(WebViewController(string: link), animated: true)
    }
    
    private func setUpScrollView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        scrollView.heightAnchor.constraint(equalToConstant: 4000).isActive = true
        
        
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        stackView.addArrangedSubview(labelS)
        labelS.translatesAutoresizingMaskIntoConstraints = false
        labelS.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        labelS.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
        labelS.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        stackView.setCustomSpacing(50, after: labelS)
        
        stackView.addArrangedSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: labelS.bottomAnchor, constant: 50).isActive = true
        if imageCell.size.width > view.frame.width {
            image.heightAnchor.constraint(equalToConstant: imageCell.size.height / (imageCell.size.width/view.frame.width)).isActive = true
            image.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        }
        else if imageCell.size.height > 250 {
            image.heightAnchor.constraint(equalToConstant: 250).isActive = true
            image.widthAnchor.constraint(equalToConstant: imageCell.size.width / (250/view.frame.height)).isActive = true
        }
        else {
            image.heightAnchor.constraint(equalToConstant: imageCell.size.height).isActive = true
            image.widthAnchor.constraint(equalToConstant: imageCell.size.width).isActive = true
        }
        stackView.setCustomSpacing(50, after: image)
        
        stackView.addArrangedSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40).isActive = true
        subLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        subLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        stackView.setCustomSpacing(50, after: subLabel)
        
        stackView.addArrangedSubview(dateAT)
        dateAT.translatesAutoresizingMaskIntoConstraints = false
        dateAT.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10).isActive = true
        dateAT.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        stackView.setCustomSpacing(50, after: dateAT)
        
        stackView.addArrangedSubview(source)
        source.translatesAutoresizingMaskIntoConstraints = false
        source.topAnchor.constraint(equalTo: dateAT.bottomAnchor, constant: 10).isActive = true
        source.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        stackView.setCustomSpacing(50, after: source)
        
        stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
        button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40).isActive = true
        stackView.setCustomSpacing(50, after: button)
        
    }
    
    private func setUpViews() {
        contentView.addSubview(labelS)
        contentView.addSubview(image)
        contentView.addSubview(subLabel)
        contentView.addSubview(dateAT)
        contentView.addSubview(source)
        contentView.addSubview(button)
        labelS.translatesAutoresizingMaskIntoConstraints = false
        labelS.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelS.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        labelS.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: labelS.bottomAnchor, constant: 50).isActive = true
        if imageCell.size.width > view.frame.width {
            image.heightAnchor.constraint(equalToConstant: imageCell.size.height / (imageCell.size.width/view.frame.width)).isActive = true
            image.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        }
        else if imageCell.size.height > 250 {
            image.heightAnchor.constraint(equalToConstant: 250).isActive = true
            image.widthAnchor.constraint(equalToConstant: imageCell.size.width / (250/view.frame.height)).isActive = true
        }
        else {
            image.heightAnchor.constraint(equalToConstant: imageCell.size.height).isActive = true
            image.widthAnchor.constraint(equalToConstant: imageCell.size.width).isActive = true
        }
//        image.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40).isActive = true
        subLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        subLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        dateAT.translatesAutoresizingMaskIntoConstraints = false
        dateAT.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10).isActive = true
        dateAT.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        source.translatesAutoresizingMaskIntoConstraints = false
        source.topAnchor.constraint(equalTo: dateAT.bottomAnchor, constant: 10).isActive = true
        source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
}
