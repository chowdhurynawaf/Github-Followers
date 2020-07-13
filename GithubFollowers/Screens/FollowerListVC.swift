//
//  FollowerListVCViewController.swift
//  GithubFollowers
//
//  Created by as on 6/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate : class {
    
    func didRequestFollowers(for username : String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    var isSearching = false
    var hasMoreFollower  =  true
    var username : String!
    var page = 1
    var followers : [Follower]  = []
    var filteredFollwer : [Follower] = []

    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
        

    }
    
    
    override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false,animated:true)
        
    }
    
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIhelper.createThreeColumnFlowlayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtontapped))
                
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtontapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                persistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    guard let error = error else{
                        self.presentGFAlertOnMainThread(title: "Success", message: "You've successfully favorited this user ", buttonTitle: "Horray")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wrong ", message: error.rawValue, buttonTitle: "OK")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                
            }
        }
    }
    
    
    
    func getFollowers(username : String , page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollwers(for: username, page: page) {[weak self] result in
            
            guard let self = self else {return}
            self.dismissLoadingView()

                   
                   switch result {
                   case .success(let followers):
                    if followers.count < 100 {self.hasMoreFollower = false}
                    self.followers.append(contentsOf: followers)
                    
                    if self.followers.isEmpty{
                        let message = "This user doesn't have any follwer 😔"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                    
                    self.updateData(on: self.followers)
                   case .failure(let error):
                       self.presentGFAlertOnMainThread(title: "Oops!!", message: error.rawValue, buttonTitle: "OK")
                       
                       DispatchQueue.main.async {
                        self.navigationController?.pushViewController(SearchVC(), animated: false)
                    }
                   }
    
               }
    }
    
    
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section , Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            cell.set(follower: follower)
            return cell
        })
  
    }
    
    func updateData(on followers : [Follower]) {
        
        var  snapshot =  NSDiffableDataSourceSnapshot<Section , Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }

        }
    
    func configureSearchController() {
        let searchController                   = UISearchController()
        searchController.searchResultsUpdater  = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.searchBar.delegate    = self
        navigationItem.searchController        = searchController
        searchController.obscuresBackgroundDuringPresentation = false

        
    }

}

extension FollowerListVC : UICollectionViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollower else {
                return
            }
            page = page + 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filteredFollwer : followers
        let follower = activeArray[indexPath.item]
        
        let destVC        = UserInfoVC()
        destVC.username   = follower.login
        destVC.delegate   = self
        let navcontroller = UINavigationController(rootViewController: destVC)
        present(navcontroller, animated: true)
        
    }
}

extension FollowerListVC : UISearchResultsUpdating  , UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {
            return
        }
        isSearching = true
        filteredFollwer = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        print(filter)
        updateData(on: filteredFollwer)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
 
}

extension FollowerListVC : FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title         = username
        page          = 1
        followers.removeAll()
        filteredFollwer.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
        
    }
    
    
}
