//
//  ViewController2.swift
//  NT_Task
//
//  Created by Mohamed El-Naggar on 7/12/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var RecipeData: Recipe? {
        didSet {
            
            tableViewData = [
                "Category     ➤ \(RecipeData!.Category)" ,
                "SubCategory  ➤ \(RecipeData!.Subcategory)" ,
                "Rating       ➤ \(RecipeData!.Rating)"
            ]
            
            self.recipeTitle?.text = RecipeData!.Title
            self.imageView?.image = RecipeData?.Image
            
            self.tableView?.reloadData()
            
        }
    }
    
    var tableViewData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController2: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        cell.textLabel?.text = tableViewData[indexPath.row]
        
        return cell
    }
}



