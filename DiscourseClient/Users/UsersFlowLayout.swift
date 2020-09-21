//
//  UsersFlowLayout.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 22/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersFlowLayout: UICollectionViewFlowLayout {
    let interSpace: CGFloat = 4.0
    let lineSpace: CGFloat = 0.0
    let numberOfCellsOnRow: CGFloat = 3
    var itemWidth : CGFloat {
        set {
            self.itemWidth = (collectionView!.frame.size.width/self.numberOfCellsOnRow)-self.interSpace
        }
        get {
            return (collectionView!.frame.size.width/self.numberOfCellsOnRow)-self.interSpace
        }
    }

    
    override init() {
        super.init()
        self.minimumLineSpacing = lineSpace
        self.minimumInteritemSpacing = interSpace
        self.scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth)
        }
        get {
            return CGSize(width: self.itemWidth, height:self.itemWidth)
        }
    }
       
}
