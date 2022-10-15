//
//  SearchVC.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var offset = 0
    var getLimit = false
    var searchQuery: String = ""
    var characters = [CharacterResponse]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setubTable()
        searchBar.delegate = self
        setupSearchBar()
    }

    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - TableView Deleagte & DataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIndentifires.searchCell, for: indexPath) as! SearchCell
        cell.configure(character: characters[indexPath.row], searchQuery: self.searchQuery)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
extension SearchVC {
    private func setubTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellIndentifires.searchCell, bundle: nil), forCellReuseIdentifier: CellIndentifires.searchCell)
    }
    
    private func getCharacters() {
        APIManager.shared.getCharacters(offset: self.offset, searchQuery: self.searchQuery) { [weak self] response, errorResponse, error in
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

// //MARK:- Search Delegates
extension SearchVC: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
        if let searchQuery = searchBar.text, !searchQuery.isEmpty {
            self.searchQuery = searchQuery
            characters.removeAll()
            getCharacters()
        } else {
            characters.removeAll()
        }
    }
    
    func setupSearchBar() {
        let attrs: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Search For Characters", attributes: attrs)
        textFieldInsideSearchBar?.leftView?.tintColor = .white
        searchBar.setImage(UIImage(named: "x.circle.fill"), for: .clear, state: .normal)
        searchBar.layer.borderWidth = 0
        searchBar.tintColor = UIColor.darkGray
    }

}
