//
//  ViewController.swift
//  DropTextFiled
//
//  Created by 钟其鸿 on 16/1/25.
//  Copyright © 2016年 Zhongqh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var dropTextField: DropDownTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropTextField.dataSourceDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

extension ViewController: DropDownTextFiledDataSourceDelegate {
    func dropDownTextField(dropDownTextField: DropDownTextField, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func dropDownTextField(dropDownTextField: DropDownTextField, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "dropdownCell"
        var cell: UITableViewCell? = dropDownTextField.dropTable.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        }
        
        cell!.textLabel!.text = "hello"
        cell!.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
    func dropDownTextField(dropdownTextField: DropDownTextField, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        resultLabel.text = "\(indexPath.row)"
    }
}
