//
//  SearchBar.swift
//  iOSEngineerCodeCheck
//
//  Created by 樋口知也 on 2022/01/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchBar: UITableViewController,UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    var repositories: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String! = ""
    var url: String! = ""
    var index: Int!
        
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        // 初期テキスト削除
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if let word = searchBar.text{
            
            if word.count != 0 {
                
                url = "https://api.github.com/search/repositories?q=\(word)"
                task = URLSession.shared.dataTask(with: URL(string: url)!) {[weak self] (data, res, err) in
                    if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                        
                        if let items = obj["items"] as? [[String: Any]] {
                            
                            self?.repositories = items
                            DispatchQueue.main.async {
                                
                                self?.tableView.reloadData()
                            }
                        }
                    }
                }
            }
            // リスト更新
            task?.resume()
        }
    }
}
