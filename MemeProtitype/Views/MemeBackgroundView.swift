//
//  MemeBackgroundView.swift
//  MemeProtitype
//
//  Created by Hao Wu on 16.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

/**
 Create a custom UIView and want to set it as UITableVIew's backgroundView. And In SentMemesTableViewController.swift, add an object of MemeBackgroundView as backgroundView of tableView in viewDidLoad(), but it don' work.
 */

import UIKit

class MemeBackgroundView: UIView {
    
    // MARK: Properties
    
    let emptyMemeImageView = UIImageView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init(image: UIImage, title: String, message: String) {
        super.init(frame: CGRect.zero)
        setupViews()
        setupImageView(image: image)
        setupLabels(title: title, message: message)
    }
    
    func setupViews() {
        addSubview(emptyMemeImageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    func setupImageView(image: UIImage) {
        emptyMemeImageView.image = image
    }
    
    func setupLabels(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        
        messageLabel.textColor = .black
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),  // "self" seems not right here.
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -45)
            ])
    }
}
