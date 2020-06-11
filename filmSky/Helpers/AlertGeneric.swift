//
//  AlertGeneric.swift
//  skyTestFilm
//
//  Created by André Brilho on 11/06/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import Foundation
import UIKit

public class Alert: NSObject {
    static func showAlertError(mensagemErro:String, titleMsgErro:String, view:UIViewController){
        let alert = UIAlertController(title: titleMsgErro, message: mensagemErro, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .destructive:
                print("destructibe")
            case .cancel:
                print("cancel")
            }}))
        view.present(alert, animated: true, completion: nil)
    }
}
