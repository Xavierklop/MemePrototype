//
//  MemeDetailViewController.swift
//  MemeProtitype
//
//  Created by Hao Wu on 13.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var memeImageView: UIImageView!

    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memedImage
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func editMeme(_ sender: Any) {
        let editMemeController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        editMemeController.meme = meme
        
        navigationController?.pushViewController(editMemeController, animated: true)
    }
}
