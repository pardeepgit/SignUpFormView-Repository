//
//  SignUpTableViewCell.swift
//  SignUpFormView
//
//  Created by Chetu India on 07/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFieldEntries: UITextField!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textFieldEntries.layer.cornerRadius = 5.0
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 10, textFieldEntries.frame.height))
        textFieldEntries.leftView = paddingView
        textFieldEntries.leftViewMode = UITextFieldViewMode.Always
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
