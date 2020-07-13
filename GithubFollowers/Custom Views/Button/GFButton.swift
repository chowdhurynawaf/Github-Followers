//
//  GFButton.swift
//  GithubFollowers
//
//  Created by as on 6/22/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame : frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(backgroundColor : UIColor , title : String){
      
        super.init(frame:.zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
        
    }
    
    
    
    private func configure() {
        layer.cornerRadius                         = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font                           = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints  = false
        
    }
    
    
    func set(backgroundColor:UIColor,title:String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        
    }

}
