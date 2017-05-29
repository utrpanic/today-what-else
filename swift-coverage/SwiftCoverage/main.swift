//
//  main.swift
//  SwiftCoverage
//
//  Created by gurren-l on 2017. 5. 26..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

let documentsUrl =  FileManager.default.urls(for: .userDirectory, in: .userDomainMask).first!

do {
    // Get the directory contents urls (including subfolders urls)
    let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
    print(directoryContents)
    
    // if you want to filter the directory contents you can do like this:
    let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
    print("mp3 urls:",mp3Files)
    let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
    print("mp3 list:", mp3FileNames)
    
} catch let error as NSError {
    print(error.localizedDescription)
}
