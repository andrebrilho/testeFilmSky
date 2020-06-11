//
//  filmSkyTests.swift
//  filmSkyTests
//
//  Created by André Brilho on 11/06/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import XCTest
import UIKit
import PromiseKit

@testable import filmSky

class filmSkyTests: XCTestCase {
    
    class DummyHomePresenter: MainFilmPresentationLogic {
        
        //jogar as funcs do presenter aqui
        var hasToShowData = false
        var hasToReloadTable = false
        var hasToRouteToDetail = false
        var hasMessageError = false
        
        func showData(listFilm: [MainFilm.Film]) { hasToShowData = true }
        func reloadTable() { hasToReloadTable = true }
        func routeToDetail() { hasToRouteToDetail = true }
        func showError() { hasMessageError = true }
        
    }
    
    //mockWorker
    class MockWorker: MainFilmWorker {
        var isSucesss = true
        
        override func getFilms() -> Promise<[MainFilm.Film]> {
            
            if isSucesss {
                let film1 = MainFilm.Film(title: "Friends", overview: "teste de description", duration: "2:10", release_year: "2010", cover_url: "htts://www.google.com", backdrops_url: ["teste","teste"])
                let film2 = MainFilm.Film(title: "Flash", overview: "teste de description Flash", duration: "5:30", release_year: "2019", cover_url: "htts://www.google.com.br", backdrops_url: ["teste","teste", "teste3"])
                
                let films:[MainFilm.Film] = [film1, film2]
                let response = films
                return Promise {seal in
                    seal.fulfill(response)
                }
            } else {
                let error: Error = NSError(domain: "", code: 404, userInfo: nil)
                return Promise {seal in
                    seal.reject(error)
                }
            }
        }
    }
    
    //quero testar o sujeito se ele foi chamado, validando a chamada do presenter
    var subject: MainFilmInteractor!
    var dummyHomePresenter: DummyHomePresenter!
    var mockWorker = MockWorker()
    
    override func setUp() {
        
        let interactor = MainFilmInteractor(worker: mockWorker)
        self.dummyHomePresenter = DummyHomePresenter()
        interactor.presenter = self.dummyHomePresenter
        self.subject = interactor
    }
    
    //testar qnd der sucesso
    func test_load_when_is_success() {
        self.mockWorker.isSucesss = true
        subject.load()
        subject.handleSuccess(model: self.mockWorker.getFilms().value!)
        XCTAssertTrue(dummyHomePresenter.hasToReloadTable)
    }
    
    func test_load_when_is_error() {
        self.mockWorker.isSucesss = false
        subject.load()
        subject.hanldeFailure(error: self.mockWorker.getFilms().error!)
        XCTAssertTrue(dummyHomePresenter.hasMessageError)
    }
    
    //testar qnd der sucesso
    var modelBeer:[MainFilm.Film] = []
    func test_handle_success(){
        subject.load()
        subject.handleSuccess(model: modelBeer)
        XCTAssertTrue(dummyHomePresenter.hasToShowData)
    }
    
    func test_handle_error(){
        subject.load()
        subject.hanldeFailure(error: NSError.init(domain: "OPS", code: 1))
        XCTAssertTrue(dummyHomePresenter.hasMessageError)
    }
    
    
    
    func test_did_select_row(){
        let filmList = MainFilm.Film(title: "The goodfather", overview: "xpto", duration: "xpto", release_year: "xpto", cover_url: "xpto", backdrops_url: ["xpto","xpto"])
        subject.listFilm = [filmList]
        subject.didSelectRow(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(dummyHomePresenter.hasToRouteToDetail)
    }
}

