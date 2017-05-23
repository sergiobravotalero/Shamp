//
//  MyOrderProductsViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class MyOrderProductsViewController: UIViewController {

    var order: Order!
    var dataSource = MyOrderProductsDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    // MARK: - Methods
    private func setupController (){
        setupTable()
        setupNavigationBar()
    }
    
    private func setupTable() {
        dataSource.order = order
        dataSource.orderProductsController = self
        tableView.dataSource = dataSource
        
        tableView.register(UINib(nibName: "MyOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrdersTableViewCell")
    }
    
    private func setupNavigationBar() {
        title = "Purchased Products"
        
        navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back Arrow"), style: .plain, target: self, action: #selector(backButtonTapped(sender:)))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonTapped(sender:UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

}
