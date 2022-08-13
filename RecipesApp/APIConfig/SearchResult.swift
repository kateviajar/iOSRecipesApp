//
//  SearchResult.swift
//  RecipesApp
//
//  Created by Pao-Hua Chien on 2022/7/24.
//

import Foundation

struct SearchResult: Codable{
    var results: [Result]
}

struct Result: Codable{
    var id: Int
    var title: String
    var image: String
}
