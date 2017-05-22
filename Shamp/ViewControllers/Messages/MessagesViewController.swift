//
//  MessagesViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshMessages(refreshControl:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    let dataSource = MessagesDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.messages = SessionHandler.shared.messagesCollection
        
        slideMenuController()?.removeLeftGestures()
        slideMenuController()?.addLeftGestures()
    }

    // MARK: - Methods
    private func setupController (){
        setupTable()
        setupNavigationBar()
    }
    
    private func setupTable() {
        dataSource.messageController = self
        tableView.dataSource = dataSource
        
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        tableView.estimatedRowHeight = 100.0

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
        RequesterHandler().getListOfMessagesWithCompletion(completion: { (success) in
            self.dataSource.messages = SessionHandler.shared.messagesCollection
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    // MARK: - IBAction
    @IBAction func showSideMenu(_ sender: Any) {
        slideMenuController()?.openLeft()
    }

}
