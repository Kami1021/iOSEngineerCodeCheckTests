//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//
import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var model = SearchViewModel()    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 検索句画面起動時に呼び出し
        SearchBar.text = "GitHubのリポジトリを検索できるよー"
        SearchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        // 初期テキスト削除
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        model.task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if let word = searchBar.text{
            
            if word.count != 0 {
                
                model.url = "https://api.github.com/search/repositories?q=\(word)"
                model.task = URLSession.shared.dataTask(with: URL(string: model.url)!) {[weak self] (data, res, err) in
                    if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                        
                        if let items = obj["items"] as? [[String: Any]] {
                            
                            self?.model.repositories = items
                            DispatchQueue.main.async {
                                
                                self?.tableView.reloadData()
                            }
                        }
                    }
                }
            }
            // リスト更新
            model.task?.resume()
        }
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            
            if let detail = segue.destination as? ResultViewController{
                detail.vc1 = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rp = model.repositories[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼び出し
        model.index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
