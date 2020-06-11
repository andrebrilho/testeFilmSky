//
//  MainFilmViewControllerTests.swift
//  filmSkyTests
//
//  Created by André Brilho on 11/06/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import XCTest
import Foundation

@testable import filmSky

class MainFilmViewControllerTests: XCTestCase {
    
    var viewController:MainFilmViewController!
    var interactor: MainFilmInteractor!
    var presenter: MainFilmPresenter!
    
    override func setUp() {
        interactor = MainFilmInteractor()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainFilmViewController") as? MainFilmViewController
        self.presenter = MainFilmPresenter()
        interactor.presenter = self.presenter
        viewController.interactor = self.interactor
        viewController.loadView()
    }
    
    func test_instanciate() throws {
        XCTAssertTrue(viewController.isKind(of: MainFilmViewController.self))
    }
    
}
