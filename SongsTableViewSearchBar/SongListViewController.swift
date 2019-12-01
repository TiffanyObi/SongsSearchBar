//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SearchScope {
    case artist
    case title
}
class SongListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songList = [Song](){
        didSet {
        tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.artist
    
    var currentText = "" {
        didSet {
            switch currentScope {
            case .artist:
                songList = Song.loveSongs.filter {
                    $0.artist.lowercased().contains(currentText.lowercased())
                }
//                for song in songList {
//                    if !song.artist.contains(currentText) {
//                        tableView.setEmptyMessage("Cannot Find Search")
//                    }
//                }
            case .title:
                songList = Song.loveSongs.filter {
                    $0.name.lowercased().contains(currentText.lowercased())
                }
//                for song in songList {
//                if !song.name.contains(currentText) {
//                    tableView.setEmptyMessage("Cannot Find Search")
//                }
//        }
    }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songDetailController = segue.destination as? SongDetailsViewController,
            let indexPath = tableView.indexPathForSelectedRow
                else {
            fatalError("Could not locate  iew controller")
        }
        
        let selectedSong = songList[indexPath.row]
            
        songDetailController.selectedSong = selectedSong
           
            
            
        }
       
    }

extension UITableView {
    
func setEmptyMessage(_ message: String) {
    guard self.numberOfRows() == 0 else {
        return
    }
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = .center;
    messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)
    messageLabel.sizeToFit()

    self.backgroundView = messageLabel;
    self.separatorStyle = .none;
}

func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
}

public func numberOfRows() -> Int {
    var section = 0
    var rowCount = 0
    while section < numberOfSections {
        rowCount += numberOfRows(inSection: section)
        section += 1
    }
    return rowCount
  }
}


extension SongListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return songList.count
    
        
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
        
        for song in songList {
            if !song.artist.contains(searchText) {
                tableView.setEmptyMessage("Cannot Find Search")
            } else if !song.name.contains(searchText) {
                tableView.setEmptyMessage("Cannot Find Search")
            } else {
                
            }
       currentText = searchText
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        tableView.reloadData()
        
        switch selectedScope {
            
        case 0:
            currentScope = .artist
            
        case 1:
            currentScope = .title
        default:
            print("Not a valid code.")
        }
    }
        
    }
    
}
    
    
    

