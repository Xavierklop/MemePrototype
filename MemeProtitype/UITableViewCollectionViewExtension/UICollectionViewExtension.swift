//
//  UICollectionViewExtension.swift
//  MemeProtitype
//
//  Created by Hao Wu on 16.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        
        messageLabel.textColor = .black
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(messageImageView)
        
        NSLayoutConstraint.activate([
            messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20),
            messageImageView.widthAnchor.constraint(equalToConstant: 150),
            messageImageView.heightAnchor.constraint(equalToConstant: 150)
            ])
        
        emptyView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
            ])
        
        emptyView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
            ])
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        
        backgroundView = emptyView
    }
    
}
