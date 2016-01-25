//
//  DropDownTextField.swift
//  DropTextFiled
//
//  Created by 钟其鸿 on 16/1/25.
//  Copyright © 2016年 Zhongqh. All rights reserved.
//

import UIKit


public protocol DropDownTextFiledDataSourceDelegate:NSObjectProtocol{
    func dropDownTextField(dropDownTextField:DropDownTextField,numberOfRowsInSection section:Int)->Int
    func dropDownTextField(dropDownTextField:DropDownTextField,cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    func dropDownTextField(dropDownTextField:DropDownTextField,didSelectRowAtIndexPath indexPath: NSIndexPath)
}

public class DropDownTextField: UITextField {
    
    public weak var dataSourceDelegate: DropDownTextFiledDataSourceDelegate?
    
    var dropTable:UITableView!
    var rowHeight:CGFloat = 50
    var dropDownTableViewHeight: CGFloat = 150
    
    private var heightConstraint: NSLayoutConstraint!
     override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        setup()
    }
    
    func setup(){
        setupTextField()
        //setupTableView()
    }
    func setupTextField(){
         addTarget(self, action: "editingChanged:", forControlEvents:.EditingChanged)
    }
     func setupTableView(){
        if dropTable == nil {
            dropTable = UITableView()
            dropTable.backgroundColor = UIColor.whiteColor()
            dropTable.layer.borderColor = UIColor.lightGrayColor().CGColor
            dropTable.layer.borderWidth = 1.0
            dropTable.showsVerticalScrollIndicator = false
            dropTable.delegate = self
            dropTable.dataSource = self
            superview!.addSubview(dropTable)
            superview!.bringSubviewToFront(dropTable)
            
            dropTable.translatesAutoresizingMaskIntoConstraints = false
            
            let leftConstraint = NSLayoutConstraint(item: dropTable, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
            let rightConstraint =  NSLayoutConstraint(item: dropTable, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
            heightConstraint = NSLayoutConstraint(item: dropTable, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: dropDownTableViewHeight)
            let topConstraint = NSLayoutConstraint(item: dropTable, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 1)
            
            NSLayoutConstraint.activateConstraints([leftConstraint, rightConstraint, heightConstraint, topConstraint])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
            tapGesture.numberOfTapsRequired = 1
            tapGesture.cancelsTouchesInView = false
            superview!.addGestureRecognizer(tapGesture)
        }
        else if  dropTable.hidden == true {
             dropTable.hidden = false
        }
    }
    func tapped(gesture: UIGestureRecognizer) {
        let location = gesture.locationInView(superview)
        if !CGRectContainsPoint(dropTable.frame, location) {
            if let dropTable = dropTable {
                
                dropTable.hidden = true
                //self.tableViewAppearanceChange(false)
            }
        }
    }
    

    func editingChanged(textField: UITextField) {
        if textField.text!.characters.count > 0 {
            setupTableView()
           // self.tableViewAppearanceChange(true)
        } else {
            if let dropDownTableView = dropTable {
              //  self.tableViewAppearanceChange(false)
            }
        }
    }
    

    
}

extension DropDownTextField:UITableViewDataSource,UITableViewDelegate{
    
    @available(iOS 2.0, *)
     public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let dataSourceDelegate = dataSourceDelegate {
            if dataSourceDelegate.respondsToSelector(Selector("dropDownTextField:numberOfRowsInSection:")) {
                return dataSourceDelegate.dropDownTextField(self, numberOfRowsInSection: section)
            }
        }
        return 0

    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
     public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        if let dataSourceDelegate = dataSourceDelegate {
            if dataSourceDelegate.respondsToSelector(Selector("dropDownTextField:cellForRowAtIndexPath:")) {
                return dataSourceDelegate.dropDownTextField(self, cellForRowAtIndexPath: indexPath)
            }
        }
        return UITableViewCell()
        
    }
  public   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let dataSourceDelegate = dataSourceDelegate {
            if dataSourceDelegate.respondsToSelector(Selector("dropDownTextField:didSelectRowAtIndexPath:")) {
                dataSourceDelegate.dropDownTextField(self, didSelectRowAtIndexPath: indexPath)
            }
        }
        self.dropTable.hidden = true 

    }

    
}
