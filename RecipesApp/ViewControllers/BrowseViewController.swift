//
//  BrowseViewController.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/24.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cuisineCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cuisineCollectionView.dataSource = self
        cuisineCollectionView.delegate = self
        cuisineCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        searchBar.delegate = self
    }
    
    // populate cuisines to the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisines.count
    }
    
    // Configure the image and title of each cuisine in the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cuisineCollectionView.dequeueReusableCell(withReuseIdentifier: "CuisineCollectionViewCell", for: indexPath) as! CuisineCollectionViewCell
        
        let cuisine = cuisines[indexPath.row]
        cell.cuisineImageView.image = UIImage(named: cuisine.imageName)
        cell.titleLabel.text = cuisine.title
        
        return cell
    }
    
    // set up collection view layout, 2 elements in one row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    // When a collection view cell is tapped, perform segue
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showResult", sender: self)
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "BrowseResultViewController") as! BrowseResultViewController
        
        resultVC.searchingString = ""
        resultVC.cuisineTitle = cuisines[indexPath.row].title
        
        // navigate to BrowseResultViewController
        self.navigationController?.pushViewController(resultVC, animated: true)
        
    }
    
    // When searchBar's button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "BrowseResultViewController") as! BrowseResultViewController
        
        resultVC.cuisineTitle = ""
        resultVC.searchingString = searchBar.text!
        
        // navigate to BrowseResultViewController
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    // pass data to BrowseResultViewController and store in the property "recipe"
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? BrowseResultViewController, let index = cuisineCollectionView.indexPathsForSelectedItems?.first{
//            destination.cuisineTitle = cuisines[index.row].title
//            destination.searchingString = searchBar.text!
//        }
//    }
}
