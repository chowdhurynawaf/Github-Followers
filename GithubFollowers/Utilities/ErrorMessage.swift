//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by as on 6/24/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import Foundation


enum GFError : String , Error {
    
    
    case invalidUserName  =  "This username is invalid , Please try again later"
    case unableToComplete =  "Unable to complete your request . Please check your internet connecttion"
    case invalidResponse  =  "Invalid response from server . Please try again"
    case invaliddata      =  "Data recieved from server is invalid , Please try again later"
    case UnableToFavorite =  "Unable to Favorite"
    case alreadyfavorites = "You've already favorited this user"
    
}
