//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by as on 7/1/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class GFRepoItemVC : GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    private func configuration() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemBlue, title: "GitHub Profile")
        
        
        
    }
    
    override func actionbuttonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
