//
//  MainFilmViewController.swift
//  skyTestFilm
//
//  Created by André Brilho on 11/06/20.
//  Copyright (c) 2020 André Brilho. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainFilmDisplayLogic: class {
    func reloadTable()
    func routeToDetail()
    func showData(_ listFilm:[MainFilm.Film])
    func showError(erro: String)
}

class MainFilmViewController: UIViewController, MainFilmDisplayLogic {
    
  @IBOutlet weak var tbl: UICollectionView!
    var filmTable:[MainFilm.Film] = []
  var interactor: MainFilmBusinessLogic?
  var router: (NSObjectProtocol & MainFilmRoutingLogic & MainFilmDataPassing)?

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }

  
  private func setup()
  {
    let viewController = self
    let interactor = MainFilmInteractor()
    let presenter = MainFilmPresenter()
    let router = MainFilmRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  override func viewDidLoad(){
    super.viewDidLoad()
    tbl.delegate = self
    tbl.dataSource = self
    tbl.register(UINib(nibName: "FilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilmCollectionViewCell")
    interactor?.load()
  }

    func reloadTable() {
        tbl.reloadData()
    }
    
    func routeToDetail() {
        router?.routeToDetail()
    }
    
    func showData(_ listFilm: [MainFilm.Film]) {
        filmTable = listFilm
    }
    
    func showError(erro: String) {
        Alert.showAlertError(mensagemErro: erro, titleMsgErro: "Alerta", view: self)
    }

}

extension MainFilmViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCollectionViewCell", for: indexPath) as? FilmCollectionViewCell {
            cell.film = filmTable[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectRow(indexPath: indexPath)
        tbl.deselectItem(at: indexPath, animated: true)
    }    
}
