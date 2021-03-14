//
//  ChatRoomTableViewCell.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
