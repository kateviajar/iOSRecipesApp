//
//  BrowseDetailViewController.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/25.
//

import UIKit

class BrowseDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var instructionsTextView: UITextView!
    
    @IBOutlet weak var ingredientTextView: UITextView!
    
    var recipeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // call the function to get API data
        searchDataById{ data in
            
            DispatchQueue.main.async {
                // fetch data
                self.titleLabel.text = data.title
                self.foodImage.downloaded(from: data.image)
                self.instructionsTextView.attributedText = data.instructions.htmlAttributedString()
                
                // get all the ingredients
                var allIngredients: String = ""
                for ingredient in data.extendedIngredients{
                    allIngredients += "\(ingredient.original)\n"
                }
                self.ingredientTextView.text = allIngredients
            }
        }
    }
    

    // Get Recipe Data from API by ID
    func searchDataById(completion: @escaping (Recipe)->()){
        // URL (Search recipe by ID)
        let url = "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=bbf14707c4114abca1a161f06175e4cf"
        
        //print("URL: \(url)")
        
        // Get the URLSession
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: URL(string: url)!) {data, response, error in
            // make sure data is not nil
            guard let data = data, error == nil else{
                print("Error getting data")
                return
            }
            
            // have data >> convert data to an object
            do{
                let result = try JSONDecoder().decode(Recipe.self, from: data)
                //print(result.title)
                completion(result)
            }
            catch {
                print("Failed to convert: \(error.localizedDescription)")
            }
            
        }
        
        // Fire off the data task
        dataTask.resume()
    }

}
