//
//  MemesManager.swift
//  MemeProtitype
//
//  Created by Hao Wu on 17.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

class MemesManager {
    
    // MARK: Properties
    
    static let shared = MemesManager()
    var memes = [Meme]()
    
    private init(){}
}
