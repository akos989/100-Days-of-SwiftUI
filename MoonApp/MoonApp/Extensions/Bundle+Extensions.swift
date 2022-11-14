//
//  Bundle+Extensions.swift
//  MoonApp
//
//  Created by Ákos Morvai on 2022. 09. 01..
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { fatalError("Could not locate \(file) in bundle.") }
        guard let data = try? Data(contentsOf: url) else { fatalError("Could not load \(file) from bundle.") }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
//        formatter.timeZone = // good to define timezones
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else { fatalError("Could not decode \(file) from bundle.") }
        
        return loaded
    }
}
