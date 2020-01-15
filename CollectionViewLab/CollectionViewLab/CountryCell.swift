//
//  CountryCell.swift
//  CollectionViewLab
//
//  Created by Maitree Bain on 1/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import ImageKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var exchangeRate: UILabel!
    
    @IBOutlet weak var weather: UILabel!
    
    func configureCell(for countryData: CountryData?) {
        
        countryImage.getImage(with: "https://www.countryflags.io/\(countryData?.name ?? "be")/shiny/64.png") { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    print("error: \(appError)")
                    self?.countryImage.image = UIImage(systemName: "flag.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.countryImage.image = image
                }
            }
            
        }
    }
    
}
