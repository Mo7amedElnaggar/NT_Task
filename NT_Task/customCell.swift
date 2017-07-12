//
//  customCell.swift
//  NT_Task
//
//  Created by Mohamed El-Naggar on 7/12/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
    var RecipeData: Recipe? {
        didSet {
            setAttributes()
        }
    }

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeCategory: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        makeImageViewCircle()
        makeUIViewShadow()
        
        // cell
        self.selectionStyle = .none
    }
    
    private func setAttributes() {
        self.recipeTitle.text = RecipeData!.Title
        self.recipeCategory.text = RecipeData!.Title
        
        self.recipeImage.image = RecipeData!.Image
        
        self.ratingLabel.text = "Rating  ➤ \(RecipeData!.Rating)"
    }
    
    
    private func makeImageViewCircle() {
        recipeImage.layer.borderColor = UIColor.black.cgColor
        recipeImage.layer.borderWidth  = 1.0
        recipeImage.layer.masksToBounds = false
        recipeImage.layer.borderColor = UIColor.white.cgColor
        recipeImage.layer.cornerRadius = recipeImage.bounds.width / 2.0
        recipeImage.clipsToBounds = true
    }
    
    private func makeUIViewShadow() {
        
        containerView.layer.cornerRadius = 10
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity =  0.7
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.shouldRasterize = true
    }

    
    
    
}
