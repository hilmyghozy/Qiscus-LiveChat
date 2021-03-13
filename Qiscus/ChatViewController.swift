//
//  ChatViewController.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit

class ChatViewController: UIViewController {
    
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Hi, \(user!.capitalized)"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
