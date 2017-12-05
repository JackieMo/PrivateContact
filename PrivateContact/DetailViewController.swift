//
//  DetailViewController.swift
//  PrivateContact
//
//  Created by Jack Mo on 2017/12/5.
//  Copyright © 2017年 Jack Mo. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //判断 person是否有值，如果有，设置UI
        if person != nil {
            nameTextField.text = person?.name
            phoneTextField.text = person?.phone
            titleTextField.text = person?.title
        }
    }

    @IBAction func savePerson(_ sender: UIBarButtonItem) {
        
        // 2.用UI更新person的内容
        person?.name = nameTextField.text
        person?.title = titleTextField.text
        person?.phone = phoneTextField.text
        
        //返回上一级
        navigationController?.popViewController(animated: true)
    }
}
