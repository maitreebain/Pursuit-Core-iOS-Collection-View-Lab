//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Maitree Bain on 1/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var countryCollection: UICollectionView!
    
    @IBOutlet weak var countrySearch: UISearchBar!
    
    var country = [CountryData](){
        didSet {
            DispatchQueue.main.async {
                self.countryCollection.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
            loadData(for: searchQuery)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCollection.dataSource = self
        countryCollection.delegate = self
        countrySearch.delegate = self
        loadData(for: "mexico")
    }
    

    func loadData(for search: String) {
        CountryAPIClient.getCountry(for: search) { [weak self] (result) in
            
            switch result {
            case .failure(let appError):
                print("error is \(appError)")
            case .success(let countryData):
                self?.country = countryData
                
            }
        }
    }
    

}

extension CountryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return country.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("cell not conforming")
        }
        
        let selectedCountry = country[indexPath.row]
        cell.configureCell(for: selectedCountry)
        return cell
    }

}
 
extension CountryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 1
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 1, bottom: 20, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

extension CountryViewController: UISearchBarDelegate {
    
}
