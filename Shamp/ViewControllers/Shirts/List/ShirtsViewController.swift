//
//  ShirtsViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class ShirtsViewController: UIViewController {
    var stamp: Stamp!
    
    var selectedShirt: Shirt?
    let dataSource = ShirtsDataSource()
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Methods
    private func setupController() {
        setupNavigationBar()
        setupTable()
    }
    
    private func setupNavigationBar() {
        title = "Select Shirt"
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back Arrow"), style: .plain, target: self, action: #selector(backButtonTapped(sender:)))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupTable(){
        dataSource.shirts = SessionHandler.shared.shirtsCollection
        dataSource.shirtsController = self
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(UINib(nibName: "ShirtsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShirtsTableViewCell")
        tableView.estimatedRowHeight = 204.5
        
        tableView.reloadData()
    }
    
    func backButtonTapped(sender:UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConfigureShirt" {
            let destinationController = segue.destination as! ConfigureShirtViewController
            destinationController.shirt = selectedShirt
            destinationController.stamp = stamp
        }
    }
}
