//
//  SongDetailsViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Tiffany Obi on 11/29/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailsViewController: UIViewController {

    @IBOutlet weak var defaultImage: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    
    var selectedSong: Song!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
   
    func updateUI() {
        defaultImage.image = UIImage(named: "loveSongs")
        defaultImage.layer.cornerRadius = 4
        songNameLabel.text = selectedSong.name
        artistNameLabel.text = selectedSong.artist
    }

}
