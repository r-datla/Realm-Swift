//
//  ViewController.swift
//  Realm-Swift
//
//  Created by Remote Tiger on 11/2/17.
//  Copyright © 2017 Remote Tiger. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var idField: UITextField!
    @IBAction func doneData(_ sender: Any) {
        model = Model()
        model!.firstName = firstName.text!
        model!.lastName = lastName.text!
        model!.id = idField.text!
        
        if let data = model{
            try! self.realm.write {
                self.realm.add(data)
                self.tableView.reloadData()
            }
            
        }
        
    }
    @IBAction func deleteData(_ sender: Any) {
        let predicate = NSPredicate(format: "id = %@", self.idField.text!)
        var object = self.realm.objects(Model.self).filter(predicate).first

        if object != nil{
            
            try! self.realm.write {
                self.realm.delete(object!)
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func updateData(_ sender: Any) {

        let predicate = NSPredicate(format: "id = %@", self.idField.text!)
        var object = self.realm.objects(Model.self).filter(predicate).first

        if object != nil{
            try! self.realm.write {
                
                model = Model()
                model!.firstName = firstName.text!
                model!.lastName = lastName.text!
                model!.id = object!.id!
                
                object = self.model
                self.realm.add(object!,update:true)
                self.tableView.reloadData()
            
            }
            
        }
      
    }
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var model:Model?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Model.self).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let individualData = self.realm.objects(Model.self)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = individualData.firstName
          cell.detailTextLabel?.text = individualData.lastName
        
        return cell
        
    }
}

