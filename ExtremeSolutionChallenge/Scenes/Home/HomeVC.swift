//
//  HomeVC.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 11/10/2022.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var offset = 0
    var getLimit = false
    var characters = [CharacterResponse]() {
        didSet {
            tableView.reloadData()
        }
    }
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setubTable()
        getCharacters()
        self.navigationController?.navigationBar.isHidden = true

    }


    @IBAction func searchBtnTapped(_ sender: UIButton) {
        let vc = SearchVC(nibName: VCs.searchVC, bundle: nil)
        self.customPresent(vc: vc)
    }
    
}

//MARK: - TableView Deleagte & DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIndentifires.homeCell, for: indexPath) as! HomeCell
        cell.configure(character: characters[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let lastSectionIndex = tableView.numberOfSections - 1
       let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
       if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && !getLimit {
           print("this is the last cell")
           let spinner = UIActivityIndicatorView(style: .whiteLarge)
           spinner.startAnimating()
           spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(80))
           self.tableView.tableFooterView = spinner
           self.tableView.tableFooterView?.isHidden = false
           offset += 10
           getCharacters()
       }
   }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsVC(nibName: VCs.detailsVC, bundle: nil)
        vc.character = characters[indexPath.row]
        self.customPresent(vc: vc)
    }
    
}
//MARK: - Private Methods
extension HomeVC {
    private func setubTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellIndentifires.homeCell, bundle: nil), forCellReuseIdentifier: CellIndentifires.homeCell)
    }
    
    private func getCharacters() {
        APIManager.shared.getCharacters(offset: self.offset) { [weak self] response, errorResponse, error in
            guard let self = self else {return}
            if let characters = response?.data?.results {
                self.getLimit = characters.count < 10 ? true : false
                self.characters.append(contentsOf: characters)
                self.stopLoading()
            } else if let errorRespone = errorResponse {
                self.showAlert(message: errorRespone.status ?? "")
            } else if let error = error {
                self.showAlert(message: error.localizedDescription )
            }
        }
    
    }
    
    private func stopLoading() {
        self.tableView.tableFooterView?.isHidden = true
        self.tableView.tableFooterView = nil
    }
}
