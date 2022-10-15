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
    var searchQuery: String = ""
    var characters = [Results]() {
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
       if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
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
        APIManager.shared.getCharacters(offset: self.offset, searchQuery: self.searchQuery) { [weak self] response, error in
            guard let self = self else {return}
            if let characters = response?.data?.results {
                self.characters.append(contentsOf: characters)
                self.stopLoading()
            }
        }
        
    }
    
    private func startLoading() {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    private func stopLoading() {
        self.tableView.tableFooterView?.isHidden = true
        self.tableView.tableFooterView = nil
    }
}

extension SearchVC: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//
//        if let searchQuery = searchBar.text {
//            self.searchQuery = searchQuery
//            getCharacters()
//        } else {
//            characters.removeAll()
//        }
//
//    }
    
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
//        self.searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 0
        searchBar.tintColor = UIColor.darkGray
    }

}
