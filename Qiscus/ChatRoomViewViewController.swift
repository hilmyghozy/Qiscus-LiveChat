//
//  ChatRoomViewViewController.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit
import QiscusCore

protocol UIChatView {
    func uiChat(viewController : ChatRoomViewViewController, didSelectMessage message: CommentModel)
    func uiChat(viewController : ChatRoomViewViewController, performAction action: Selector, forRowAt message: CommentModel, withSender sender: Any?)
    func uiChat(viewController : ChatRoomViewViewController, canPerformAction action: Selector, forRowAtmessage: CommentModel, withSender sender: Any?) -> Bool
    func uiChat(viewController : ChatRoomViewViewController, firstMessage message: CommentModel, viewForHeaderInSection section: Int) -> UIView?
}

class ChatRoomViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    private var presenter: UIChatPresenter = UIChatPresenter()
    var room : RoomModel?
    var comments: [[CommentModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendMsgButton(_ sender: Any) {
        let message = CommentModel()
        message.message = textField.text!
        message.type    = "text"
        message.roomId  = room!.id

        QiscusCore.shared.sendMessage(message: message, onSuccess: { (comment) in
            
        }) { (error) in
             print((error.message))
        }
    }
 
}

extension ChatRoomViewViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatRoomTableViewCell
        let message = CommentModel()
        if message.type == "text" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatRoomTableViewCell
            cell.msgLbl.text = message.message
            tableView.reloadData()
        }
       
        return cell
    }
}
