//
//  API.swift
//  NT_Task
//
//  Created by Mohamed El-Naggar on 7/12/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct URLs {
    
    static let server = "http://api2.bigoven.com/recipes"
    static let API_Key = "axV15293h59oU9Z853fw48CmI1H1Js"
}


class API {
    
    class func getRecipes(_ pageNumber: Int , completion: @escaping (_ success: Bool , _ recipes: [Recipe]?) -> Void) {
        
        let parameters: [String : Any] = [
            "API_Key" : URLs.API_Key
        ]
        
        Alamofire.request(URLs.server, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        
        .responseJSON { (response) in
            
            switch(response.result) {
                
            case .failure(let error):
                print(error)
                completion(false,  nil)
                
                
            case .success(let val):
                let json = JSON(val)
                
                
                if let result = json["Results"].array {
                    
                    // Returned Data
                    var RecipesItem = [Recipe]()
            
                    result.forEach({ (recipeJSON) in
                        
                        let newRecipe = Recipe(jsonObject: recipeJSON)
                        
                        // Push Only ( not Nil ) Recipe
                        if newRecipe != nil {
                            RecipesItem.append(newRecipe!)
                        }
                    })
                    
                    completion(true , RecipesItem)
                    return
                }
                
                completion(false , nil)
                
            }
        }
        
    }
    
    class func downloadImage(url: URL , completion: @escaping (_ success: Bool , _ image: UIImage?) -> Void) {
        
        
        var image = UIImage(named: "DefaultImage.jpg")!
        
        Alamofire.request(url).responseData { (response) in

            switch(response.result) {
            case .failure(let error):
                print(error)
                completion(false ,nil)
                
            case .success(_):
                image = UIImage(data: response.data!)!
                completion(true , image)
            }
            
        }

    }
    
    
}
