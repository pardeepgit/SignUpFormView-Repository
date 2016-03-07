//
//  ViewController.swift
//  SignUpFormView
//
//  Created by Chetu India on 07/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    
    let signUpPlaceholderArray = ["First Name", "Last Name", "Mobile", "Email", "Password", "DOB", "Salary", "Dept", "Position", "Floor"]
    let signUpArray = ["first_name", "last_name", "mobile", "email", "password", "dob", "salary", "dept", "position", "floor"]
    var signUpDict = NSMutableDictionary()
    var isValidate = Bool()

    
    @IBOutlet weak var tableViewSignUp: UITableView!
    @IBOutlet weak var buttonSignUp: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        for index in 0..<signUpArray.count {
            signUpDict.setValue("", forKey: signUpArray[index])
        }
        
        tableViewSignUp.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Hi inside of an viewWillAppear Method.")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableViewSignUp.separatorColor = UIColor.clearColor()
    }
    
    
    
    
    
    
    // MARK:  UITextField Delegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        if textField.tag == 0
        {
            self.view.endEditing(true)
            return false
        }
        else if textField.tag == 3
        {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            tableViewSignUp.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            
            let paths = tableViewSignUp.indexPathsForVisibleRows
            let firstRow = paths![0].row
            
            let actualXPosition = (textField.tag - firstRow + 1) * 70 + 70
            print("Actual x position: \(actualXPosition)")

            
            let xPoint = textField.frame.origin.x
            let yPoint = textField.frame.origin.y
            let width = textField.frame.size.width

            print("Textfield x position: \(xPoint)")
            print("Textfield y position: \(yPoint)")
            print("Textfield width position: \(width)")
            
            self.view.endEditing(true)
            
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.tag == signUpPlaceholderArray.count-1 {
            textField.resignFirstResponder()
            return true
        }
        else {
            
            
            let paths = tableViewSignUp.indexPathsForVisibleRows
            var flag = false
            
            for path in paths! {
                
                if path.row == textField.tag+1
                {
                    flag = true
                    break;
                }
            }
            
            if flag
            {
                let indexpath: NSIndexPath = NSIndexPath(forRow: textField.tag+1, inSection: 0)
                let cell: SignUpTableViewCell = (tableViewSignUp.cellForRowAtIndexPath(NSIndexPath(forRow: textField.tag+1, inSection: 0)) as? SignUpTableViewCell!)!
                
                cell.textFieldEntries.becomeFirstResponder()
                tableViewSignUp.scrollToRowAtIndexPath(indexpath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
            }
            else
            {
                let indexpath: NSIndexPath = paths![0]
                let cell: SignUpTableViewCell = (tableViewSignUp.cellForRowAtIndexPath(indexpath) as? SignUpTableViewCell!)!
                
                cell.textFieldEntries.becomeFirstResponder()
            }
            
            return false
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.tag == signUpPlaceholderArray.count-1
        {
            textField.returnKeyType = .Done
        }
        else
        {
            textField.returnKeyType = .Next
        }
        
        if textField.tag == 2
        {
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.returnKeyType = UIReturnKeyType.Done
        }
        else if textField.tag == 3
        {
            textField.keyboardType = UIKeyboardType.EmailAddress
        }
        else
        {
            textField.keyboardType = UIKeyboardType.Default
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let value = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        signUpDict.setValue(value, forKey: signUpArray[textField.tag])
    }

    
    
    
    
    
    // MARK:  UITableView DataSource
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 70.0
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        return signUpPlaceholderArray.count
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell: SignUpTableViewCell = (tableView.dequeueReusableCellWithIdentifier("SignUpTableViewCell") as? SignUpTableViewCell!)!
        
        tableView.separatorColor = UIColor.clearColor()
        
        cell.textFieldEntries.placeholder = signUpPlaceholderArray[indexPath.row]
        cell.textFieldEntries.tag = indexPath.row
        cell.titleLabel.text = signUpPlaceholderArray[indexPath.row]
        
        
        if signUpDict.valueForKey(signUpArray[indexPath.row]) as! String != ""
        {
            cell.textFieldEntries.text = signUpDict.valueForKey(signUpArray[indexPath.row]) as? String
        }
        
        // For secure password entry.
        if indexPath.row == 4 {
            cell.textFieldEntries.secureTextEntry = true
        }
        else {
            cell.textFieldEntries.secureTextEntry = false
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

