//
//  FileManager+Ext.swift
//  Hey! Hydrate!
//
//  Created by Iiro Alhonen on 15.6.2022.
//

import Foundation

extension FileManager {
    static var sharedContainerURL: URL {
        let appGroupIdentifier = "group.com.niftytreestudios.heyhydrate.content"
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)
        else { preconditionFailure("Expected a valid app group container") }
        return url
    }
}
