//
//  FileManager+Ext.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.6.2022.
//

import Foundation

extension FileManager {
    static func sharedContainerURL() -> URL {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.niftytreestudios.heyhydrate.content")!
    }
}
