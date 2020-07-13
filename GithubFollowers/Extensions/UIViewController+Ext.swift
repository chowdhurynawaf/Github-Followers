//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by as on 6/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerview : UIView!
extension UIViewController {
    
    func presentGFAlertOnMainThread(title : String , message : String , buttonTitle : String) {
        
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func  presentSafariVC(with url : URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor = #colorLiteral(red: 0.1086650565, green: 0.725255549, blue: 0.9792419076, alpha: 1)
        present(safariVC,animated: true)
    }
    
    
    func showLoadingView() {
        containerview = UIView(frame: view.bounds)
        view.addSubview(containerview)
        
        containerview.alpha           = 0
        containerview.backgroundColor = .systemBackground
                    
        UIView.animate(withDuration: 0.25) {
            containerview.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerview.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
        
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerview.removeFromSuperview()
            containerview = nil
        }
    }
    
    func showEmptyStateView(with message : String , in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
    }
}
