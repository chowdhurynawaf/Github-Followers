//
//  UIhelper.swift
//  GithubFollowers
//
//  Created by as on 6/26/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

struct UIhelper {
    static func createThreeColumnFlowlayout(in view : UIView) -> UICollectionViewFlowLayout {
       
       let width                    = view.bounds.width
       let padding : CGFloat        = 12
       let minimumSpacing : CGFloat = 10
       let availablewidth = width - (padding * 2) - (minimumSpacing * 2)
       let itemWidth      = availablewidth/3
       
       let flowLayout     = UICollectionViewFlowLayout()
       flowLayout.sectionInset  = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
       flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
       
       return flowLayout
   }
    
}
