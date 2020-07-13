//
//  FavoriteListVC.swift
//  GithubFollowers
//
//  Created by as on 6/22/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController {
   
    
    
    
    let tableView = UITableView()
    var favorites : [Follower] = []
    //var delegate : UserInfoVCDelegate!
    weak var delegate : FollowerListVCDelegate!


    




    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate   = self
        tableView.dataSource = self
        
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.tableFooterView = UIView(frame: .zero)

    }
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFavorites() {
        persistenceManager.retrievefavorite {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let favorites):
                
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favorites !\n Please add someone", in: self.view)
                }else {
                    self.configureTableView()
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
    }
    
}

extension FavoriteListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell     =  tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite =  favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite        = favorites[indexPath.row]
        let destVC          = FollowerListVC()
        destVC.title        = favorite.login
        destVC.username     = favorite.login
        
 
        
        
        
        

        
        navigationController?.pushViewController(destVC, animated: true)

        

    }
    
 
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite        = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        persistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            
            guard let self = self else {return}
            
            if self.favorites.count == 0 {
                DispatchQueue.main.async {
                        self.showEmptyStateView(with: "Please add someone 😕", in: self.view)

                }
            }
            
            
            
            guard let error = error else {return}
            
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
            
        }
        
        
        
    }
    
}



