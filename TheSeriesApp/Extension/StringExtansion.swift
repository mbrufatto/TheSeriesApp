//
//  StringExtansion.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 10/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

extension String {
    
    func getYearOfDate() -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // This formate is input formated .
        
            let formateDate = dateFormatter.date(from:self)
            dateFormatter.dateFormat = "yyyy" // Output Formated
            guard let dateFormatted = formateDate else {
                return ""
            }
            return dateFormatter.string(from: dateFormatted)
    }
}
