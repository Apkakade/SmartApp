//
//  NetworkRechebilityVC.swift
//  MUMABI MAHANAGR APP
//
//  Created by Onkar Borse on 31/01/19.
//  Copyright © 2019 Anushree Kakade. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireNetworkActivityIndicator
import SwiftyJSON
import SVProgressHUD
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class NetworkRechebilityVC: UIViewController {

    let network = NetworkManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // If the network is reachable show the main controller
         self.navigationController?.navigationBar.isHidden = true
        network.reachability.whenReachable = { _ in
            self.showMainController()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    private func showMainController() -> Void {
        DispatchQueue.main.async {
//            let MainScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenVC") as! MainScreenViewController
//            self.navigationController?.pushViewController(MainScreenVC, animated: true)
//        }
    }
}
}
