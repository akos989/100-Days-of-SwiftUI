//
//  FileManager+Extension.swift
//  Bucket List
//
//  Created by Morvai Ákos on 2022. 10. 04..
//

import Foundation

extension FileManager {
    static var documentsDirectoryUrl: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
