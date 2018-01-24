//
//  MapViewController.swift
//  TestingCoreData
//
//  Created by Ahmed on 24/01/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var delegate:AddressSelected!
    var addressInfo:CLPlacemark?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(MapViewController.getTapLocation(_:)))
        tapGesture.numberOfTapsRequired=1
        mapView.addGestureRecognizer(tapGesture)
        mapView.delegate=self
        let location = CLLocationCoordinate2D(latitude: 17.4532265, longitude: 78.3016495)
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        mapView.setRegion(region, animated: true)
        // Do any additional setup after loading the view.
    }

    @objc func getTapLocation(_ sender:UITapGestureRecognizer){
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        getAddressFromLatLon(pdblLatitude: coordinate.latitude, withLongitude: coordinate.longitude)
        
        
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double){
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
                    return
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = (pm[0].location?.coordinate)!
                    annotation.title = pm[0].name!
                    annotation.subtitle = pm[0].country!
                    self.mapView.addAnnotation(annotation)
                    self.addressInfo=pm[0]
                }
        })
        
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if self.addressInfo == nil{
            self.showAlert(title: "Error!", message: "Choose an Address")
        }else{
            if let _del=self.delegate{
                _del.mapViewSelectedAddress(addressInfo: self.addressInfo!)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    


}
protocol AddressSelected{
    func mapViewSelectedAddress(addressInfo:CLPlacemark)
}
