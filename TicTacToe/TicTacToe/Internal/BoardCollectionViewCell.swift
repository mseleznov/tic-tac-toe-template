//
//  BoardCollectionViewCell.swift
//  TicTacToe
//
//  Created by Mykhailo Seleznov on 02.05.2022.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    private let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(textLabel)

        textLabel.translatesAutoresizingMaskIntoConstraints = false

        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true

        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 32.0)
    }

    func applyViewState(_ state: BoardView.CellState) {
        textLabel.text = state.text
        textLabel.textColor = state.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
