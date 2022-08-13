//
//  User.swift
//  RecipesApp
//
//  Created by Yuriko Uchida on 2022-07-30.
//

import Foundation
import UIKit


class User{
    public var photo = UIImage()
    public var name: String
    public var country: String
    public var dateOfBirth: Date
    public var isFemale: Bool
    public var isPhoto: Bool

    init(){
        self.name = ""
        self.country = ""
        self.dateOfBirth = Date()
        self.isFemale = false
        self.isPhoto = false
    }
}
