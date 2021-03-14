//
//  ChatViewController.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit
import QiscusCore
import SwiftyJSON

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var chatRoomTable: UITableView!
    
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Conversation"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setHidesBackButton(true, animated: true)
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.newConversation(_:)))
        self.navigationItem.rightBarButtonItems = [plusButton]
    }
    
    @IBAction func newConversation(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showNC", sender: self)
        
    }
    
}
