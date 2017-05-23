//
//  MyOrdersViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshMessages(refreshControl:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()

    var selectedOrder: Order!
    let dataSource = MyOrdersDataSource()
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.orders = SessionHandler.shared.orders
        
        slideMenuController()?.removeLeftGestures()
        slideMenuController()?.addLeftGestures()
    }
    
    // MARK: - Methods
    private func setupController (){
        setupTable()
        setupNavigationBar()
    }
    
    private func setupTable() {
        dataSource.odersController = self
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MyOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrdersTableViewCell")
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        tableView.addSubview(self.refreshControl)
    }
    
    private func setupNavigationBar() {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSForegroundColorAttributeName: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = UIColor.signatureYellow()
        navigationController?.navigationBar.tintColor = UIColor.signatureYellow()
    }
    
    @objc private func refreshMessages(refreshControl: UIRefreshControl) {
        RequesterHandler().getListOfOrders(completion: { (success) in
            self.dataSource.orders = SessionHandler.shared.orders
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    // MARK: - IBAction
    @IBAction func showSideMenu(_ sender: Any) {
        slideMenuController()?.openLeft()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProducts" {
            let destinationController = segue.destination as! MyOrderProductsViewController
            destinationController.order = selectedOrder
        }
    }
}
