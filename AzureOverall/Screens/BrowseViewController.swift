//
//  BrowseViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/16/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
  
  lazy var searchBar: UISearchBar = {
    let sb = UISearchBar()
    return sb
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
