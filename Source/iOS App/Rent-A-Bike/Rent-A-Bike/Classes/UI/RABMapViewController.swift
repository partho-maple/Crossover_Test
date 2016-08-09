//
//  RABMapViewController.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit
import Siesta
import ARSLineProgress
import JLToast
import SwiftyJSON
import GoogleMaps
import CoreLocation


class RABMapViewController: UIViewController, JitenshaAPIFetchDelegate, GMSMapViewDelegate {

    
    @IBOutlet var googleMapView: GMSMapView!
    var placePicker: GMSPlacePicker?
    var markers : [GMSMarker] = [] // for future use
    var markerDictionary = Dictionary<String, GMSMarker>() // for future use
    var camera: GMSCameraPosition? = nil
    var selectedMarker: GMSMarker?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        self.navigationItem.hidesBackButton = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        JitenshaAPI.fetchPlaceDelegate = self
        
        if Utils.isConnectedToNetwork() {
            ARSLineProgress.show()
            JitenshaAPI.fetchRentalPlaces()
        } else {
            let toast = JLToast.makeText("Internet connection not available.", delay: 1, duration: 3)
            toast.show()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
     // MARK: - Navigation
     
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FromLocationToPaymentSegue") {
            let destViewController: PaymentViewController = segue.destinationViewController as! PaymentViewController

            destViewController.title = self.selectedMarker?.title
        }
     }
 
    
    // MARK: - JitenshaAPIFetchDelegate methodes
    
    func didFinishFetchingPlacesWith(places: [Place]) {
        ARSLineProgress.hide()
        self.addPlacePickersInMapView(places)
    }
    
    func didFinishFetchingPlacesWithError(errorMsg: String) {
        ARSLineProgress.hide()
    }
    
    
    
    // MARK: - GMSMapViewDelegate methodes
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {

        return false
    }
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView) -> Bool {
        
        return false
    }
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        self.selectedMarker = marker
        self.performSegueWithIdentifier("FromLocationToPaymentSegue", sender: self)
    }
    
    // MARK: - Member methodes
    
    func addPlacePickersInMapView(places: [Place]) {

        dispatch_async(dispatch_get_main_queue(),{
            [unowned self] in
            
            self.googleMapView.delegate = self
            self.googleMapView.myLocationEnabled = true
            var camera: GMSCameraPosition? = nil
            camera = GMSCameraPosition.cameraWithLatitude((places[0].location?.lat)!, longitude: (places[0].location?.lng)!, zoom: 12)
            self.googleMapView.mapType = kGMSTypeNormal
            self.googleMapView.camera = camera!
            
            
            for i in 0..<places.count {
    
                let place : Place = places[i]
                var position: CLLocationCoordinate2D = CLLocationCoordinate2D()
                position.latitude = (place.location?.lat)!
                position.longitude = (place.location?.lng)!
                
                let lat = (place.location?.lat)!
                let lng = (place.location?.lng)!
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(lat, lng)
                
                var icon : UIImage = UIImage(named: "icon_me.png")!
                icon = icon.imageWithAlignmentRectInsets(UIEdgeInsetsMake(-(icon.size.height/2), -(icon.size.width/2), 0, 0))
                
                marker.icon = icon
                marker.groundAnchor = CGPointMake(0.5, 0.5)
                marker.appearAnimation = kGMSMarkerAnimationPop
                marker.infoWindowAnchor = CGPointMake(0.44, 0.45);
                marker.title = place.name
                marker.flat = true
                marker.userData = place.identifire
                marker.snippet = "Rent-A-Bike"
                marker.map = self.googleMapView
                
                self.markers.append(marker)
                self.markerDictionary[place.name!] = marker
            }
            
        })
    }
    
}
