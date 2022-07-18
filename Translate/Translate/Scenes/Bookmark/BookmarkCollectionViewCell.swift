//
//  BookmarkCollectionViewCell.swift
//  Translate
//
//  Created by 민성홍 on 2022/07/18.
//

import SnapKit
import UIKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"

    private var sourceBookmarkTextStackView = BookmarkTextStackView(language: .ko, text: "", type: .source)
    private var targetBookmarkTextStackView = BookmarkTextStackView(language: .en, text: "", type: .target)



    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0

        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true

        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach { stackView.addArrangedSubview($0) }

        return stackView
    }()

    func setup(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0

        sourceBookmarkTextStackView = BookmarkTextStackView(language: bookmark.sourceLanguage, text: bookmark.sourceText, type: .source)

        targetBookmarkTextStackView = BookmarkTextStackView(language: bookmark.translatedLanguage, text: bookmark.tranlatedText, type: .target)

        stackView.subviews.forEach { $0.removeFromSuperview() }

        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach { stackView.addArrangedSubview($0) }

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }

        layoutIfNeeded()
    }
}
