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

    override func viewDidLoad() {
        super.viewDidLoad()
        getAddressFromLatLon(pdblLatitude:17.4532261, withLongitude: 78.3016495)
    }

    func insertData(addressInfo:CLPlacemark){
      let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let businnesInfo=Business(context: context)
        let address=Address(context: context)
        let timeDuration=WorkingHour(context: context)
        businnesInfo.name="First Value"
        businnesInfo.pnone_number=9873027210
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
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = pdblLatitude
        center.longitude = pdblLongitude
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    self.insertData(addressInfo:placemarks![0])
                }
        })
        
    }
}


