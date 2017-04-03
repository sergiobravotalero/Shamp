//
//  SlideMenuViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class SlideMenuViewController: UIViewController, SlideMenuControllerDelegate {

    let dataSource = SlideMenuDataSource()
    var mainViewController: UIViewController?
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Nethods
    private func setupController() {
        setupTable()
    }
    
    private func setupTable(){
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CellWithArrowTableViewCell", bundle: nil), forCellReuseIdentifier: "CellWithArrowTableViewCell")
    }

}
