//
//  HomeDetailViewController.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/24.
//

import UIKit

class HomeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var instructionsTextView: UITextView!
    
    @IBOutlet weak var ingredientTable: UITableView!
    
    var recipe: Recipe? // to store a Recipe object passed from the HomeViewController
    var ingredients = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredients = recipe!.extendedIngredients // store ingredients array
        
        // fetch data
        titleLabel.text = recipe?.title
        foodImage.downloaded(from: recipe!.image)
        instructionsTextView.attributedText = recipe?.instructions.htmlAttributedString()
    }
    
    // Add ingredients to the table view
    // return the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTable.dequeueReusableCell(withIdentifier: "homeDetailTableCell", for: indexPath) as! HomeDetailTableViewCell
        
        let ingredient = ingredients[indexPath.row]
        cell.ingredientLabel.text = ingredient.original
        
        return cell
    }
}

// For displaying HTML in UITextView
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                font-family: -apple-system;
                font-size: 15px;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}
