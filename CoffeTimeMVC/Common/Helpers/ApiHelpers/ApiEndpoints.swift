//
//  ApiEndpoints.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 25.08.2023.
//

import Foundation

struct ApiEndpoints {
    static let login = "/User/Authorization"
    static let register = "/User/Register"
    static let allProducts = "/Product/GetAll"
    static let allCafeProducts = "/Product/GetProductsCafe"
    static let cafeProduct = "/Product/GetProduct"
    static let favoriteSet = "/Favorite/Set"
    static let favoriteUnset = "/Favorite/Unset"
    static let allCafe = "/Cafe/GetAll"
    static let cafe = "/Cafe/GetCafe"
}
