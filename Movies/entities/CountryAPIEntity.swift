//
//  CountryAPIEntity.swift
//  Movies
//
//  Created by Margarita Slesareva on 06.06.2023.
//

struct CountryAPIEntity: Decodable, CustomStringConvertible {
    let country: String
    
    var description: String {
        return country
    }
}
