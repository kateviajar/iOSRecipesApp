//
//  HomeViewController.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var recipesJson = [Recipe]() // to store a json object
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
        // call the function to get API data
        getData { data in
            self.recipesJson = data
            DispatchQueue.main.async {
                self.errorLabel.isHidden = true
                self.homeTableView.reloadData()
            }
        }
       
    }
    
    // return the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesJson.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeTableCell", for: indexPath) as! HomeTableViewCell
        
        let recipe = recipesJson[indexPath.row]
        cell.recipeNameLabel?.text = recipe.title
        cell.recipeImageView?.downloaded(from: recipe.image)

        return cell
    }
    
    // set the height of row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // when a row is tapped, perform segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    // pass data to HomeDetailViewController and store in the property "recipe"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HomeDetailViewController{
            destination.recipe = recipesJson[homeTableView.indexPathForSelectedRow!.row]
        }
    }
    
    // a function to get data from API
    func getData(completion: @escaping ([Recipe])->()){
        // URL (Get random 10 recipes)
        let url = "https://api.spoonacular.com/recipes/random?apiKey=20a2972effed4acfb713eedd94ff4898&number=10"
        
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
                let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                // print(result)
                completion(result.recipes)
            }
            catch {
                DispatchQueue.main.async{
                    self.errorLabel.isHidden = false
                }
                print("Failed to convert: \(error.localizedDescription)")
            }
        }
        
        // Fire off the data task
        dataTask.resume()
    }

}

// For show UIImageView from a URL
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

