//
//  HomeViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    var pickerShouldShowCategories = true
    var selectedStamp: Stamp?
    let dataSource = HomeDataSource()
    
    let priceCategories = ["All", "< 10.000", "10.000 - 50.000", "50.000 - 100.000", "> 100.000"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        slideMenuController()?.removeLeftGestures()
        slideMenuController()?.addLeftGestures()
    }

    // MARK: - Method

    private func setupController (){
        setupTable()
        setupNavigationBar()
        
        loadItems()
    }
    
    private func setupTable() {
        dataSource.homeController = self
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "StampTableViewCell", bundle: nil), forCellReuseIdentifier: "StampTableViewCell")
        tableView.estimatedRowHeight = 155.0
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func setupNavigationBar() {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSForegroundColorAttributeName: UIColor.signatureGray()]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func updateStamps() {
        SVProgressHUD.show()
        RequesterHandler().getListOfStampsWithCompletion(completion: { (suceeded) in
            self.dataSource.stamps = SessionHandler.shared.stampsCollection
            self.tableView.reloadData()
            self.setupPickerView()
            SVProgressHUD.dismiss()
        })
    }
    
    private func loadItems() {
        SVProgressHUD.show()
        RequesterHandler().getListOfStampsWithCompletion(completion: { (suceeded) in
            self.dataSource.stamps = SessionHandler.shared.stampsCollection
            self.tableView.reloadData()
            self.setupPickerView()
            
            RequesterHandler().getListOfShirtsWithCompletion(completion: { (succeeded) in
                SVProgressHUD.dismiss()
            })
        })
    }
    
    private func showFilterPicker() {
        self.pickerView.isHidden = false
        self.toolBar.isHidden = false
    }
    
    private func hideFilterPicker() {
        pickerView.isHidden = true
        toolBar.isHidden = true
    }
    
    // MARK: - IBAction
    @IBAction func searchButtonTapped(_ sender: Any) {
        hideFilterPicker()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let filterAction = UIAlertAction(title: "Filter by Category", style: .default, handler: { (action) in
            self.pickerShouldShowCategories = true
            self.pickerView.reloadAllComponents()
            self.showFilterPicker()
        })
        
        let priceAction = UIAlertAction(title: "Filter by Price", style: .default, handler: { (action) in
            self.pickerShouldShowCategories = false
            self.pickerView.reloadAllComponents()
            self.showFilterPicker()
        })
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(filterAction)
        actionSheet.addAction(priceAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func doneToolBarButtonTapped(_ sender: Any) {
        hideFilterPicker()
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        slideMenuController()?.openLeft()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShirts" {
            let destination = segue.destination as! ShirtsViewController
            destination.stamp = selectedStamp
        }
    }
}

