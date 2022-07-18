//
//  UserDefaults+.swift
//  Translate
//
//  Created by 민성홍 on 2022/07/12.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case bookmarks
    }

    var bookmarks: [Bookmark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.rawValue) else { return [] }

            return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
        }

        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: Key.bookmarks.rawValue)
        }
    }
}
