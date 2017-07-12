//
//  Recipe.swift
//  NT_Task
//
//  Created by Mohamed El-Naggar on 7/12/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Recipe {
    var Title: String
    var Description: String = "Default Description"
    var Category: String
    var Subcategory: String
    var Image: UIImage = UIImage(named: "DefaultImage.jpg")!
    var Rating: Double
    
    // Ingredients (Horizontal - list / grid)
    // Instructions
    
 
    init?(jsonObject: JSON) {
        
        guard let title = jsonObject["Title"].string else { return nil }
        guard let category = jsonObject["Category"].string else { return nil }
        guard let subCategory = jsonObject["Subcategory"].string else { return nil }
        guard let PhotoUrl = jsonObject["PhotoUrl"].url else { return nil }
        guard let rating = jsonObject["StarRating"].double else { return nil }
        
        self.Title = title
        self.Category = category
        self.Subcategory = subCategory
        self.Rating = rating
        
        API.downloadImage(url: PhotoUrl) { (success , image) in
            if success {
                // DONE
                // print("Done")
                self.Image = image!
            } else {
                self.Image = UIImage(named: "DefaultImage.jpg")!
            }
        }

    }
}
