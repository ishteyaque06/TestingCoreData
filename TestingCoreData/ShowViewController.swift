//
//  ShowViewController.swift
//  TestingCoreData
//
//  Created by Ahmed on 23/01/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var result=[Report]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        fetchData()
    }
   func initialSetUp(){
    let cellNib=UINib(nibName: "DetailsTableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "Cell")
    tableView.rowHeight=30
    tableView.estimatedRowHeight=tableView.rowHeight
    tableView.rowHeight=UITableViewAutomaticDimension
    }
    
    func fetchData(){
      let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let result = try context.fetch(Business.fetchRequest())
            for item in result as! [Business]{
                let addRess=(item.adrerss?.first_Name)!+" ,"+(item.adrerss?.country)!+" ,"+(item.adrerss?.pin_Code)!
                self.result.append(Report(name: item.name, phone_number: item.pnone_number, address:addRess))
            }
            tableView.reloadData()
        }catch{
           print(error.localizedDescription)
        }
    }
}
extension ShowViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath)as? DetailsTableViewCell
        cell?.report=result[indexPath.row]
        return cell!
    }
}
