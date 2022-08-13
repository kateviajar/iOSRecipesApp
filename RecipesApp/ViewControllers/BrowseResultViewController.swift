//
//  BrowseResultViewController.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/25.
//

import UIKit

class BrowseResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var resultTableView: UITableView!
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    // to store the cuisine title and searching string passed from the BrowseViewController
    var cuisineTitle: String = ""
    var searchingString: String = ""
    
    // to store API data in the Result array
    var resultsJson = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        resultTableView.dataSource = self
        resultTableView.delegate = self
        
        // Hide the message label
        self.emptyLabel.isHidden = true
        
        // call the function to get API data
        searchData{ data in
            self.resultsJson = data
            DispatchQueue.main.async {
                self.resultTableView.reloadData()
            }
        }
    }
    
    // Populate searching results to the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(resultsJson.isEmpty){
            // show the label
            self.emptyLabel.isHidden = false
            emptyLabel.text = "Can not find the recipes!"
            return 0
        }
        else{
            self.emptyLabel.isHidden = true
            return resultsJson.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "browseTableCell", for: indexPath) as! HomeTableViewCell
        
        let result = resultsJson[indexPath.row]
        cell.recipeNameLabel?.text = result.title
        cell.recipeImageView?.downloaded(from: result.image)
        
        return cell
    }
    
    // set the height of row of table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // when a row is tapped, perform segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showResultDetails", sender: self)
    }
    
    // Pass the recipe id to BrowseDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BrowseDetailViewController{
            destination.recipeId = resultsJson[resultTableView.indexPathForSelectedRow!.row].id
        }
    }
    

    // a function to get data from API
    func searchData(completion: @escaping ([Result])->()){
        // URL (Search by Cuisine or KeyWords)
        var url: String = ""
        
        if(cuisineTitle != ""){
            url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=bbf14707c4114abca1a161f06175e4cf&number=20&cuisine=" + cuisineTitle
        }
        if(searchingString != ""){
            url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=bbf14707c4114abca1a161f06175e4cf&number=20&query=" + searchingString
        }
        
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
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                // print(result)
                completion(result.results)
            }
            catch {
                print("Failed to convert: \(error.localizedDescription)")
            }
        }
        
        // Fire off the data task
        dataTask.resume()
    }

}
