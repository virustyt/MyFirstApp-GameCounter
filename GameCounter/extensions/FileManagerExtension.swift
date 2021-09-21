//
//  FileManagerExtension.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 19.09.2021.
//

import Foundation

extension FileManager {
    static let urlForGameModel = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("GameModel").appendingPathExtension("json")
}

