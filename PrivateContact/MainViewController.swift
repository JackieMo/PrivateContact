//
//  MainViewController.swift
//  PrivateContact
//
//  Created by Jack Mo on 2017/12/5.
//  Copyright © 2017年 Jack Mo. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    //联系人数组
    var personList = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData { (list) in
//            print(list)
            
            //拼接数组，闭包中定义好的代码在需要的时候执行，需要 self， 指定语境
            self.personList += list
            
            //刷新表格
            self.tableView.reloadData()
        }
    }

    private func loadData(completion:@escaping (_:[Person]) -> ()) -> () {
        DispatchQueue.global().async {
            print("正在努力加载中...")
            Thread.sleep(forTimeInterval: 1)
            var arrayM = [Person]()
            for i in 0..<20 {
                let p = Person()
                p.name = "zhangsan - \(i)"
                p.phone = "186" + String(format:"%06d", arc4random_uniform(1000000))
                p.title = "boss"
                arrayM.append(p)
            }
            
            //主线程回调
            DispatchQueue.main.async {
                //回调，执行闭包
                completion(_:arrayM)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let person = self.personList[indexPath.row]
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.phone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetailVc", sender: indexPath)
    }
    
    // MARK - navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 类型转换 as
        // swift中，除了string之外，绝大多数使用as 需要 ? / !
        // as! / as? 直接根据as前面的返回值来决定, 如destination不是可选的，就用"!"，如果是可选的就用"?"
        
        let vc = segue.destination as! DetailViewController
        if let index = sender as? IndexPath {
            vc.person = self.personList[index.row]
        }
    }
}
