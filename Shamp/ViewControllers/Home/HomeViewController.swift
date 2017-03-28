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

    var selectedStamp: Stamp?
    let dataSource = HomeDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    // MARK: - Method

    private func setupController (){
        setupTable()
        setupNavigationBar()
        
        updateStamps()
    }
    
    private func setupTable() {
        dataSource.homeController = self
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "StampTableViewCell", bundle: nil), forCellReuseIdentifier: "StampTableViewCell")
        tableView.estimatedRowHeight = 155.0
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
    
    // MARK: - IBAction
    @IBAction func searchButtonTapped(_ sender: Any) {
        pickerView.isHidden = !pickerView.isHidden
        toolBar.isHidden = pickerView.isHidden
    }
    
    @IBAction func doneToolBarButtonTapped(_ sender: Any) {
        pickerView.isHidden = !pickerView.isHidden
        toolBar.isHidden = pickerView.isHidden
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShirts" {
            let destination = segue.destination as! ShirtsViewController
            destination.stamp = selectedStamp
        }
    }
}

