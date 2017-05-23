//
//  SlideMenuViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import FCAlertView


class SlideMenuViewController: UIViewController, SlideMenuControllerDelegate {

    let dataSource = SlideMenuDataSource()
    var mainViewController: UIViewController?
    var currentIndex = 0
    
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
    
    func userTappedSignOut() {
        slideMenuController()?.closeLeft()
        
        let alertController = UIAlertController(title: "Attention", message: "Are you sure you want to sign out from current session?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOutAction = UIAlertAction(title: "Sign out", style: .destructive, handler: { (action) in
            SessionHandler.shared.removeAll()
            ShoppingCart.shared.removeAll()
            UserDefaultsHandler.shared.removeAll()
            
            ViewControllersHandler().showLoginAsRoot(window: self.view.window)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(signOutAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
