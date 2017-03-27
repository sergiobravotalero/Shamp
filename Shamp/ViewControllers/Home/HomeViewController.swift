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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        updateStamps()
    }

    // MARK: - Method
    private func updateStamps() {
        SVProgressHUD.show()
        RequesterHandler().getListOfStampsWithCompletion(completion: { (suceeded) in
            SVProgressHUD.dismiss()
        })
    }
    
    private func setupNavigationBar() {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSForegroundColorAttributeName: UIColor.signatureGray()]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
