//
//  User.swift
//  GithubFollowers
//
//  Created by as on 6/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import Foundation


struct User : Codable  {
    var login : String
    let avatarUrl : String
    var name : String?
    var location : String?
    var bio : String?
    let publicRepos : Int
    let publicGists : Int
    //let html_url : String
    let htmlUrl : String
    let followers : Int
    let following : Int
    let createdAt : String
}
