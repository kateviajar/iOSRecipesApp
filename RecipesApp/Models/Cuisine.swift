//
//  Cuisine.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/25.
//

import Foundation

// hardcode cuisine data
//    let cuisines = ["American", "British", "Caribbean", "Chinese", "European", "French", "German", "Indian", "Italian", "Korean", "Latin American", "Mediterranean", "Spanish", "Thai", "Vietnamese"]

struct Cuisine {
    var title: String
    var imageName: String
}

// hardcode cuisine data
let cuisines: [Cuisine] = [
    Cuisine(title: "American", imageName: "American"),
    Cuisine(title: "British", imageName: "British"),
    Cuisine(title: "Caribbean", imageName: "Caribbean"),
    Cuisine(title: "Chinese", imageName: "Chinese"),
    Cuisine(title: "European", imageName: "European"),
    Cuisine(title: "French", imageName: "French"),
    Cuisine(title: "German", imageName: "German"),
    Cuisine(title: "Indian", imageName: "Indian"),
    Cuisine(title: "Italian", imageName: "Italian"),
    Cuisine(title: "Korean", imageName: "Korean"),
    Cuisine(title: "Latin American", imageName: "LatinAmerican"),
    Cuisine(title: "Mediterranean", imageName: "Mediterranean"),
    Cuisine(title: "Spanish", imageName: "Spanish"),
    Cuisine(title: "Thai", imageName: "Thai"),
    Cuisine(title: "Vietnamese", imageName: "Vietnamese")
]
