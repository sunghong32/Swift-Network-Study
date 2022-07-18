//
//  Type.swift
//  Translate
//
//  Created by 민성홍 on 2022/07/18.
//

import UIKit

enum `Type` {
    case source
    case target

    var color: UIColor {
        switch self {
            case .source: return .label
            case .target: return UIColor.systemPink
        }
    }
}
