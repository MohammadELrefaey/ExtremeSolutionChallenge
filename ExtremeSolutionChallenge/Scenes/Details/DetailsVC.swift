//
//  DetailsVC.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import UIKit

//enum Collection {
//    case
//}
class DetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var comicsCollection: UICollectionView!
    @IBOutlet weak var eventsCollection: UICollectionView!
    @IBOutlet weak var seriesCollection: UICollectionView!
    @IBOutlet weak var storiesCollection: UICollectionView!

    //MARK: - Properties
    var character: Results!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setubUI()
    }

    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK:- CollectionView Delegate & DataSource
extension DetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comicsCollection {
            return character.comics?.items?.count ?? 0
            
        } else if collectionView == eventsCollection {
            return character.events?.items?.count ?? 0
            
        } else if collectionView == seriesCollection {
            return character.series?.items?.count ?? 0
            
        } else {
            return character.stories?.items?.count ?? 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIndentifires.detailsCell, for: indexPath) as! DetailsCell
        
        if collectionView == comicsCollection {
            cell.configure(item: character.comics?.items?[indexPath.row])

        } else if collectionView == eventsCollection {
            cell.configure(item: character.events?.items?[indexPath.row])

        } else if collectionView == seriesCollection {
            cell.configure(item: character.series?.items?[indexPath.row])

        } else if collectionView == storiesCollection {
            cell.configure(item: character.stories?.items?[indexPath.row])

        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 100, height: 150)
    }
    
}

//MARK: - Private Methods
extension DetailsVC {
    private func setupCollection() {
        let collectionsArray: [UICollectionView] = [comicsCollection, eventsCollection, seriesCollection, storiesCollection]
        
        for collection in collectionsArray {
            collection.delegate = self
            collection.dataSource = self
            collection.register(UINib(nibName: CellIndentifires.detailsCell, bundle: nil), forCellWithReuseIdentifier: CellIndentifires.detailsCell)
        }
     }


    private func setubUI() {
        let urlString = "\(character.thumbnail?.path ?? "")/portrait_incredible.\(character.thumbnail?.extension_ ?? "")"
        headerImg.setImage(with: urlString)
        nameLbl.text = character.name ?? ""
        descriptionLbl.text = character.description ?? ""
        print(character.description ?? "")
    }
    
}
