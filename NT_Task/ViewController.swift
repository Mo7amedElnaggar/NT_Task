//
//  ViewController.swift
//  NT_Task
//
//  Created by Mohamed El-Naggar on 7/12/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var recipes = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var pageNumber: Int = 1 // For API indexing
    var isLoading: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var refresh: UIRefreshControl {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(ViewController.loadMore), for: .valueChanged)
        
        return refresh
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.addSubview(refresh)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none

        loadMore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func loadMore() {
        guard !isLoading else { return }
        
        isLoading = true
        
        API.getRecipes(pageNumber) { (success, recipes) in
            if success {
                // DONE
                
                self.recipes.append(contentsOf: recipes!)
                self.isLoading = false
                self.pageNumber += 1
                
            } else {
                // ERROR
                // Future Work
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetails" {
            
            let destVC = segue.destination as! ViewController2

            let indexPath = tableView.indexPath(for: (sender as? customCell)!)!

            destVC.RecipeData = recipes[indexPath.row]
        }
    }
    
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = self.recipes.count
        
        if indexPath.row == count - 1 {
            loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
}



extension ViewController: UITableViewDataSource {
    
    // By Default this function Returns 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? customCell {
            
            cell.RecipeData = recipes[indexPath.row]
            
            return cell
        }
        
        
        return UITableViewCell()
        
    }
    
}
