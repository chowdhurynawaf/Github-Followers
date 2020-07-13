//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by as on 7/2/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import Foundation

extension Date {
    
    
    func convertToMonthYearFormat() -> String {
        
        let dateformatter        = DateFormatter()
        dateformatter.dateFormat = "MMM yyyy"
        return dateformatter.string(from: self)
    }
}
