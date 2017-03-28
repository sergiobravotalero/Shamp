//
//  ShoppingCartViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    let dataSource = ShoppingCartDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.products = ShoppingCart.shared.products
        tableView.reloadData()
    }

    // MARK: - Methods
    private func setupController() {
        setupNavigationBar()
        setupTable()
    }
    
    private func setupNavigationBar() {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSForegroundColorAttributeName: UIColor.signatureGray()]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setupTable() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        tableView.estimatedRowHeight = 238.5
        tableView.reloadData()
    }

    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if !ShoppingCart.shared.products.isEmpty {
            performSegue(withIdentifier: "showPlaceOrder", sender: nil)
        } else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to have added products first before proceeding")
        }
    }
}
