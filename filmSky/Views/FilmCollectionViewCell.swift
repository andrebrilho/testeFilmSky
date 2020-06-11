//
//  FilmCollectionViewCell.swift
//  skyTestFilm
//
//  Created by André Brilho on 11/06/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    var film:MainFilm.Film?{
        didSet{
            setData()
        }
    }
    
    fileprivate func setData(){
        lbl.text = film?.title
        img.image = UIImage.init(named: "emptyImage")
        img.af_cancelImageRequest()
        img.af_setImage(withURL: URL(string:((film?.cover_url)!))!, filter: AspectScaledToFitSizeFilter(size: CGSize(width: 100, height: 170)), imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: { (_) in
                })
            }
        }
