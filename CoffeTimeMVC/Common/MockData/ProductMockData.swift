//
//  ProductMockData.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 19.12.2023.
//

import Foundation

let attributeArray: [AttributeModel] = [
    AttributeModel(id: "1", description: "Крепость", iconType: "strength"),
]


let productMockData: ProductModel = ProductModel(
    cofeId: "1",
    id: "2",
    productName: "Espresso",
    price: 20,
    favorite: false,
    imagesPath: "Coffe1",
    attribute: NSSet(array: attributeArray)
)
