//
//  MemeCollectionViewController.swift
//  MemeProtitype
//
//  Created by Hao Wu on 13.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    
    // TODO: fix this with singleton
    var memes: [Meme]! {
        return MemesManager.shared.memes
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView!.reloadData()
    }

    // MARK: Action
    
    @IBAction func addMeme(_ sender: Any) {
        let memeEditorController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        navigationController?.pushViewController(memeEditorController, animated: true)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if memes.count == 0 {
            collectionView.indicatorStyle = .default
            collectionView.backgroundView?.isHidden = false
            collectionView.setEmptyView(title: "No Meme yet.", message: "Let's add new Meme!", messageImage: UIImage(named: "empty folder")!)
        } else {
            collectionView.indicatorStyle = .white
            collectionView.backgroundView?.isHidden = true
        }
        
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Configure the cell
        cell.memeImageView.image = meme.memedImage 
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: set flow layout
    
    func setFlowLayout() {
        let space: CGFloat = 3
        let dimension = (view.frame.width - 2 * space) / 3
        
        flowLayout.minimumLineSpacing = 3 * space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

}
