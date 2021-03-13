//
//  newConversationViewController.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit
import QiscusCore


protocol NewConversationVCDelegate{
    func showProgress()
    func loadContactsDidSucceed(contacts : [MemberModel])
    func loadContactsDidFailed(message: String)
}

class newConversationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    internal var contactAll: [MemberModel]? = nil
    var keywordSearch : String? = nil
    var page : Int = 1
    var stopLoad : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "New Conversation"
        getContacts()
    }
    
    func getContacts(){
        if self.stopLoad == true{
            return
        }
        
        QiscusCore.shared.getUsers(searchUsername: keywordSearch, page: page, limit: 20, onSuccess: { (contacts, metaData) in
            if contacts.count != 0 {
                self.page += 1
                self.loadContactsDidSucceed(contacts: contacts)
            } else {
                self.stopLoad = true
            }
        }) { (error) in
            self.loadContactsDidFailed(message: error.message)
        }
    }
    
    func chat(withRoom room: RoomModel){
        let target = ChatViewController()
        target.room = room
        self.navigationController?.pushViewController(target, animated: true)
    }


}
extension newConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if let contact = self.contactAll{
            let userId = contact[indexPath.row].email
            QiscusCore.shared.chatUser(userId: userId, onSuccess: { (room, comments) in
                 self.chat(withRoom: room)
            }) { (error) in
                print("error chat: \(error.message)")
            }
        }
    }
}

extension newConversationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactAll?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewConversationTableViewCell
        
        if let contacts = self.contactAll{
            let contact = contacts[indexPath.row]
            cell.contactLbl.text = contact.username
            print(" \(contact.username)")
            
            if indexPath.row == contacts.count - 1{
                self.getContacts()
            }
        }
       
        self.tableView.tableFooterView = UIView()

        return cell
    }
}

extension newConversationViewController: NewConversationVCDelegate {
    func loadContactsDidSucceed(contacts: [MemberModel]) {
        if let contact = self.contactAll{
           self.contactAll = contact + contacts
        }else{
              self.contactAll = contacts
        }
        self.tableView.reloadData()
        
    }
    internal func showProgress() {
        //show progress
    }
    
    internal func loadContactsDidFailed(message: String) {
        //load contact failed
    }
}
