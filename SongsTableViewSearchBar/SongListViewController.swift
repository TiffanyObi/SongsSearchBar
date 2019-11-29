//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SongListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songList = [Song](){
        didSet {
        tableView.reloadData()
        }
    }
    
    var currentText = "" {
        didSet {
            songList = Song.loveSongs.filter { $0.name.lowercased().contains(currentText.lowercased())}
        }
    }

    
    func loadData() {
        songList = Song.loveSongs
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



extension SongListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        let songInRow = songList[indexPath.row]
        
        songCell.textLabel?.text = songInRow.name
        
        songCell.detailTextLabel?.text = songInRow.artist
        
        return songCell
    }
    
    
}

extension SongListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        
       currentText = searchText
        }
        
    }
    
    
    
    
    

