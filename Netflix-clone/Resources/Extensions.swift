//
//  Extensions.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 23/08/22.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
