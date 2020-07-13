//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by as on 6/27/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate : class {
    
    func didTapGithubProfile(for user : User)
    func didTapGetFollowers(for user : User)
}


class UserInfoVC: UIViewController {
    var username : String!
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center)
    var itemViews : [UIView] = []
    
    weak var delegate : FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layOutUI()
        getUserInfo()

        
 
        
 
        
        

    }
    
    func configureViewController() {
        view.backgroundColor              = .systemBackground
         let doneButton                    = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
         
         navigationItem.rightBarButtonItem = doneButton
         
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
             guard let self = self else {return}
             switch result{
             case .success(let user):
                 DispatchQueue.main.async {
                    self.configureUIElements(with:user)
                    
                 }
             case .failure(let error):
                 self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
             }
         }
    }
    
    func configureUIElements(with user:User) {
        
         let repoItemVC = GFRepoItemVC(user: user)
         repoItemVC.delegate = self
        
         let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Using Github Since \(user.createdAt.convertToDisplayFormat())"

        
        
        
    }
    
    
    
    func layOutUI() {
        
        itemViews = [headerView,itemViewOne,itemViewTwo , dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        
        
        
        
        
        let padding : CGFloat = 20

        
        NSLayoutConstraint.activate([
        
        
        
    headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
    headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
    itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
    itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
    itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
    itemViewOne.heightAnchor.constraint(equalToConstant: 140),
    
    
    itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
    itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
    itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
    itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
    
    dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
    dateLabel.heightAnchor.constraint(equalToConstant: 18),
    dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
    dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        
        
        ])
    }
    
    func add(childVC : UIViewController , to containerView : UIView) {
        
        
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
        
        
        
        
    }
    
   @objc func dismissVC() {
        dismiss(animated: true)
    }
    

   

}

extension UserInfoVC : UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url  = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        
        presentSafariVC(with: url)
        
        
    }
    
    func didTapGetFollowers(for user: User) {
        
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "OK")
            
            return
        }
        delegate.didRequestFollowers(for: user.login)
        print("user login  : " , user.login)


        dismissVC()
        
    }
    
    

    
    
    
    
    
    
}
