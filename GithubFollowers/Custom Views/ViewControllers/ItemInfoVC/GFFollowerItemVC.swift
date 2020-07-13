//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by as on 7/1/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    private func configuration() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        
    }
    
    override func actionbuttonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
