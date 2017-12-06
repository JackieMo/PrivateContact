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
    
    ///完成回调属性
    //闭包的返回值是可选的
    var completionCallBack: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //判断 person是否有值，如果有，设置UI
        if person != nil {
            nameTextField.text = person?.name
            phoneTextField.text = person?.phone
            titleTextField.text = person?.title
        }
        else {
            person = Person()
        }
    }

    @IBAction func savePerson(_ sender: UIBarButtonItem) {
        
        // 2.用UI更新person的内容
        person?.name = nameTextField.text
        person?.title = titleTextField.text
        person?.phone = phoneTextField.text
        
        // 3.执行闭包回调
        // OC 中执行block前都必须判断是否有值，否则容易崩溃
        // ! 强行解包，不建议用
        // ？ 可选解包 -> 如果 闭包为nil， 就什么也不做
        completionCallBack?() //completionCallBack!()
        
        //返回上一级
        navigationController?.popViewController(animated: true)
    }
    
    
}
