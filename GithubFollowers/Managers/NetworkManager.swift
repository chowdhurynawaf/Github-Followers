//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by as on 6/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class NetworkManager {
    
    
   static let shared = NetworkManager()
   private let baseUrl       = "https://api.github.com/"
   let cache         = NSCache<NSString,UIImage>()
    
    private init() {}
    
    
    func getFollwers(for username : String , page : Int , completed : @escaping (Result<[Follower] , GFError >) -> Void){
        
       let endpoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invaliddata))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invaliddata))
            }
            
        }
        
        task.resume()
 
    }
    
    func getUserInfo(for username : String  , completed : @escaping (Result< User , GFError >) -> Void){
        
       let endpoint = baseUrl + "users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invaliddata))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invaliddata))
            }
            
        }
        
        task.resume()
        

       
        
    }
    
}