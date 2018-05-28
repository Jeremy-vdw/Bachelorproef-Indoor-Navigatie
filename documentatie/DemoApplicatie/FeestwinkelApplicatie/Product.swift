//
//  Product.swift
//  FeestwinkelApplicatie
//
//  Created by Jeremie Van de Walle on 14/05/18.
//  Copyright © 2018 Jeremie Van de Walle. All rights reserved.
//

import Foundation

class Product {
    
    var name: String;
    var code: String;
    var price: Double;
    var description: String;
    var stock: Int;
    var size: String;
    var associatedProducts: [Product] = [];
    
    init(name: String, code: String, price: Double, description: String = "", stock: Int = 0, size: String = ""){
        self.name = name;
        self.code = code;
        self.price = price;
        self.description = description
        self.stock = stock;
        self.size = size;
    }
    
    
}
