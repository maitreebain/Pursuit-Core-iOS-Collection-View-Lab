//
//  CountryModel.swift
//  CollectionViewLab
//
//  Created by Maitree Bain on 1/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation

struct CountryData: Decodable {
    let name: String?
    let alpha2Code: String?
    let currencies: [currencyInfo]?
}

struct currencyInfo: Decodable {
    let code: String?
    let name: String?
}
