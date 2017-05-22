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
    var pickerShouldShowPrices = false
    var pickerShouldShowArtists = false
    
    var isSearchBarActive = false
    
    var selectedStamp: Stamp?
    let dataSource = HomeDataSource()
    
    let priceCategories = ["All", "< 10.000", "10.000 - 50.000", "50.000 - 100.000", "> 100.000"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideFilterPicker()
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
        
        searchBar.delegate = self
        searchBarHeightConstraint.constant = 0
        
        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.signatureYellow()]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as! [String : Any], for: .normal)
        
        tableView.register(UINib(nibName: "StampTableViewCell", bundle: nil), forCellReuseIdentifier: "StampTableViewCell")
        tableView.estimatedRowHeight = 155.0
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func setupNavigationBar() {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSForegroundColorAttributeName: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = UIColor.signatureYellow()
        navigationController?.navigationBar.tintColor = UIColor.signatureYellow()
        
        if let advanceSearch = SessionHandler.shared.listOfFeatures?.advanceSearch, advanceSearch {
            print("Advance search enabled")
        } else {
            searchButton.isEnabled = false
            searchButton.tintColor = UIColor.clear
        }
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
            self.pickerShouldShowArtists = false
            self.pickerShouldShowPrices = false
            
            self.pickerView.reloadAllComponents()
            self.showFilterPicker()
        })
        actionSheet.addAction(filterAction)
        
        let priceAction = UIAlertAction(title: "Filter by Price", style: .default, handler: { (action) in
            self.pickerShouldShowPrices = true
            self.pickerShouldShowArtists = false
            self.pickerShouldShowCategories = false
            
            self.pickerView.reloadAllComponents()
            self.showFilterPicker()
        })
        actionSheet.addAction(priceAction)
        
        let artistAction = UIAlertAction(title: "Filter by Artist", style: .default, handler: { (action) in
            self.pickerShouldShowPrices = false
            self.pickerShouldShowArtists = true
            self.pickerShouldShowCategories = false
            
            self.pickerView.reloadAllComponents()
            self.showFilterPicker()
        })
        actionSheet.addAction(artistAction)
        
        let nameAction = UIAlertAction(title: "Filter by Name", style: .default, handler: { (action) in
            self.searchBarHeightConstraint.constant = 44
        })
        actionSheet.addAction(nameAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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

