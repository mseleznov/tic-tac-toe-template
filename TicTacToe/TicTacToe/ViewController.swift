//
//  ViewController.swift
//  TicTacToe
//
//  Created by Mykhailo Seleznov on 02.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var boardView: BoardView!

    var viewState = BoardView.State(cells: [[BoardView.CellState(text: "", color: .black),BoardView.CellState(text: "", color: .black),BoardView.CellState(text: "", color: .black)],
                                            [BoardView.CellState(text: "", color: .black),BoardView.CellState(text: "", color: .black),BoardView.CellState(text: "", color: .black)],
                                            [BoardView.CellState(text: "", color: .black),BoardView.CellState(text: "", color: .black),BoardView.CellState(text: "", color: .black)]])

    override func viewDidLoad() {
        super.viewDidLoad()

        boardView.delegate = self

        boardView.applyViewState(state: viewState)
    }


}

extension ViewController: BoardViewDelegate {
    func didSelectCell(at indexPath: IndexPath) {
        var cells = viewState.cells

        cells[indexPath.section][indexPath.row] = .init(text: "X", color: .green)

        viewState = .init(cells: cells)

        boardView.applyViewState(state: viewState)
    }


}

