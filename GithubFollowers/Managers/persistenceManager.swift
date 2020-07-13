//
//  persistenceManager.swift
//  GithubFollowers
//
//  Created by as on 7/3/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

enum persistenceActionType {
    case add, remove
}

enum persistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "fovorites"
    }
    
    static func updateWith(favorite: Follower , actionType : persistenceActionType , completed : @escaping (GFError?) -> Void) {
        retrievefavorite { result in
            switch result{
            case .success(let favorites):
                var retrieveFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrieveFavorites.contains(favorite) else{
                        completed(.alreadyfavorites)
                        return }
                    retrieveFavorites.append(favorite)
                    
                case .remove:
                    retrieveFavorites.removeAll { $0.login == favorite.login
                    
                       }
                    }
                    
                    completed(save(favorites: retrieveFavorites))
                
                
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrievefavorite(completed :  @escaping (Result<[Follower],GFError>)->Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
            
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.UnableToFavorite))
        }
    }
    
    static func save(favorites:[Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defaults.set(encoderFavorites, forKey: Keys.favorites)
            return nil
        }catch{return .UnableToFavorite}
            
    }
    

    
}
