//
//  SentMemesTableTableViewController.swift
//  MemeProtitype
//
//  Created by Hao Wu on 13.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    // MARK: Properties
    
    var memes: [Meme]! {
        return MemesManager.shared.memes
    }
    
    
    // MARK: Life Cycle
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // test
//        let emptyBackgroundView = MemeBackgroundView(image: UIImage(named: "empty folder")!, title: "Title", message: "Message")
//        tableView.backgroundView = emptyBackgroundView
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView!.reloadData()
    }
    
    // MARK: Action
    
    @IBAction func addMeme(_ sender: Any) {
        let memeEditorController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        navigationController?.pushViewController(memeEditorController, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if memes.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
            tableView.setEmptyView(title: "No Meme yet.", message: "Let's add new Meme!", messageImage: UIImage(named: "empty folder")!)
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as! SentMemesTableViewCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        cell.memeTextLabel.text = meme.topText + "..." + meme.bottomText
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 5.5
        return height
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MemesManager.shared.memes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}

