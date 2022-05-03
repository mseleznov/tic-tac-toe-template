//
//  BoardView.swift
//  TicTacToe
//
//  Created by Mykhailo Seleznov on 02.05.2022.
//

import UIKit

protocol BoardViewDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath)
}

class BoardView: UIView {
    struct CellState {
        let text: String
        let color: UIColor
    }

    struct State {
        let cells: [[CellState]]
    }

    weak var delegate: BoardViewDelegate?

    private let collectionView: UICollectionView
    private var viewState = State(cells: [])

    override init(frame: CGRect) {
        let layout = GridCollectionViewLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)

        super.init(frame: frame)

        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        let layout = GridCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(coder: coder)

        setupCollectionView()
    }

    func applyViewState(state: State) {
        viewState = state

        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: "BoardCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
}

extension BoardView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellRow = indexPath.item % 3
        let cellColumn = indexPath.item / 3

        delegate?.didSelectCell(at: IndexPath(row: cellRow, section: cellColumn))
    }
}

extension BoardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardCell", for: indexPath) as? BoardCollectionViewCell else {
            return UICollectionViewCell()
        }

        let cellRow = indexPath.item % 3
        let cellColumn = indexPath.item / 3
        if cellColumn < viewState.cells.count {
            let column = viewState.cells[cellColumn]
            if cellRow < column.count {
                cell.applyViewState(column[cellRow])
            }
        }

        cell.backgroundColor = .lightGray

        return cell
    }
}
