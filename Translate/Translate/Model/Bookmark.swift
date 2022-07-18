//
//  Bookmark.swift
//  Translate
//
//  Created by 민성홍 on 2022/07/12.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language

    let sourceText: String
    let tranlatedText: String
}


