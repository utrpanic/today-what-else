//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by box-jeon-mac-mini on 2020/03/11.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, TicTacToeListener {
    
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable, offGameBuilder: OffGameBuilder, ticTacToeBuilder: TicTacToeBuilder) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }

    func cleanupViews() {
        if let currentChild = self.currentChild {
            self.viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuilder
    private let ticTacToeBuilder: TicTacToeBuilder
    
    private var currentChild: ViewableRouting?
    
    private func attachOffGame() {
        let offGame = self.offGameBuilder.build(withListener: self.interactor)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController: offGame.viewControllable)
    }
    
    private func attachTicTacToe() {
        let ticTacToe = self.ticTacToeBuilder.build(withListener: self.interactor)
        self.currentChild = ticTacToe
        attachChild(ticTacToe)
        viewController.present(viewController: ticTacToe.viewControllable)
    }
    
    func routeToTicTacToe() {
        self.detachCurrentChild()
        self.attachTicTacToe()
    }
    
    func routeToOffGame() {
        self.detachCurrentChild()
        self.attachOffGame()
    }
    
    private func detachCurrentChild() {
        if let currentChild = self.currentChild {
            self.detachChild(currentChild)
            self.viewController.dismiss(viewController: currentChild.viewControllable)
            self.currentChild = nil
        }
    }
}
