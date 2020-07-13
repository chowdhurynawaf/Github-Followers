//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by as on 6/21/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import SafariServices


class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    let swiftyTrendButton  = GFButton(backgroundColor: .systemGreen, title: "Swifty Trends")
    
    var isUserNameEntered : Bool { return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        configureSwiftyTrendActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true,animated:true)

    }
    
    
    
    //Mark :- Logo Image
    
    func configureLogoImageView() {
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named : "gh-logo")!
        
        NSLayoutConstraint.activate([
        
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)

        ])
    }
    
    
    
    //__________________________________________________________________________________

    //Mark :- Text field staff
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
        
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)

        
        ])
    }
    
    
    
    func createDismissKeyboardTapGesture() {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
   
    
    
    //__________________________________________________________________________________
    
    
    
    //Mark :- Get Followers Button staff
    
    
    func configureCallToActionButton() {
        
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 150),
        //callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -130),
        callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
        callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
        
        
        ])
    }
    
    

    
    
    
    
    
    
    
    
    // swifty trend button configuration
    
    func configureSwiftyTrendActionButton() {
        
        view.addSubview(swiftyTrendButton)
        swiftyTrendButton.addTarget(self, action: #selector(showSwiftyTrends), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        swiftyTrendButton.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 20),

        //swiftyTrendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        swiftyTrendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
        swiftyTrendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        swiftyTrendButton.heightAnchor.constraint(equalToConstant: 50),
        
        
        
        ])
    }
    
    
    @objc func showSwiftyTrends() {
        
        buttonAnimation(btn: swiftyTrendButton)
        
        let url = "https://github.com/trending/swift?since=daily"
        
       
            presentSafariVC(with: URL(string: url)!)
 
    }
    
    
    
    
    
    @objc func pushFollowerListVC() {
        
        buttonAnimation(btn:callToActionButton)
        
        guard isUserNameEntered else {
            
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username . We need to know who to look for 😊", buttonTitle: "OK")
            
            
            return}
        
        let followerListVC      = FollowerListVC()
        followerListVC.username = usernameTextField.text!
        followerListVC.title    = usernameTextField.text!
        usernameTextField.text  = ""
        navigationController?.pushViewController(followerListVC, animated: true)

           
       }
    
    

    

  
    //__________________________________________________________________________________
    
    
    func buttonAnimation(btn:UIButton){
          let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
          colorAnimation.fromValue = UIColor.systemGray.cgColor
          colorAnimation.duration = 1  // animation duration
          // colorAnimation.autoreverses = true // optional in my case
          // colorAnimation.repeatCount = FLT_MAX // optional in my case
    btn.layer.add(colorAnimation, forKey: "ColorPulse")
       }
    
    

    

}


//


extension SearchVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        pushFollowerListVC()
        return true
    }
    
}
