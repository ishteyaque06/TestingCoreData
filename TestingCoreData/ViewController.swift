//
//  ViewController.swift
//  TestingCoreData
//
//  Created by Ahmed on 23/01/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {

    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    var addressInfo:CLPlacemark?
    private struct StoryBoradConstant{
    static let nameError="Name can't be blank"
    static let phoneError="Phone Number Can't be blank"
    static let addressError="Address can't be blank"
    static let errorMsg="Error!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate=self
        phoneNumberTextField.delegate=self
    }

    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if nameTextField.text?.count==0{
            self.showAlert(title: StoryBoradConstant.errorMsg, message:StoryBoradConstant.nameError)
        }else if phoneNumberTextField.text?.count==0{
            self.showAlert(title: StoryBoradConstant.errorMsg, message:StoryBoradConstant.phoneError)
        }else if addressInfo == nil{
            self.showAlert(title:StoryBoradConstant.errorMsg, message:StoryBoradConstant.addressError)
        }else{
            insertData(addressInfo: addressInfo!)
            self.nameTextField.text=nil
            self.phoneNumberTextField.text=nil
            self.addressInfo=nil
            self.addressButton.setTitle("Get Address", for: .normal)
        }
    }
    func insertData(addressInfo:CLPlacemark){
      let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let businnesInfo=Business(context: context)
        let address=Address(context: context)
        let timeDuration=WorkingHour(context: context)
        businnesInfo.name=nameTextField.text!
        businnesInfo.pnone_number=phoneNumberTextField.text!
        address.country=addressInfo.country
        address.first_Name=addressInfo.name
        address.pin_Code=addressInfo.postalCode
        address.state=addressInfo.locality
        address.street_Name=addressInfo.subLocality
        timeDuration.date="Monday"
        timeDuration.hour_to="9 PM"
        timeDuration.hour_From="10 AM"
        businnesInfo.adrerss=address
        businnesInfo.timeDuration=timeDuration
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toMapView"{
            if let dv=segue.destination as? MapViewController{
                dv.delegate=self
            }
        }
    }
}
extension ViewController:AddressSelected{
    func mapViewSelectedAddress(addressInfo: CLPlacemark) {
        self.addressInfo=addressInfo
        self.addressButton.setTitle(addressInfo.name!+" ,"+addressInfo.subLocality!+" ,"+addressInfo.locality!+" ,"+addressInfo.country!+" ,"+addressInfo.postalCode!, for: .normal)
    }
}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField==self.phoneNumberTextField{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        return true
    }
}
extension UIViewController{
    func showAlert (title : String, message : String) {
        let alert=UIAlertController(title: title, message:message, preferredStyle: .alert)
        let okaction=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
}

