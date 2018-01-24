//
//  ShowViewController.swift
//  TestingCoreData
//
//  Created by Ahmed on 23/01/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    var result=[Business]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
      let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            result = try context.fetch(Business.fetchRequest())
            print(result)
        }catch{
           print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
