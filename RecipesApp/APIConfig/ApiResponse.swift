//
//  ApiResponse.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/24.
//

import Foundation

struct ApiResponse: Codable{
    var recipes: [Recipe]
}

struct Recipe: Codable{
    var id: Int
    var title: String
    var readyInMinutes: Int
    var servings: Int
    var image: String
    var summary: String
    var instructions: String
    var extendedIngredients: [Ingredient]
}

struct Ingredient: Codable{
    var id: Int
    var original: String
}
