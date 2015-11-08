//
//  ViewController.swift
//  PublicSafety
//
//  Created by Itua Ijagbone on 11/7/15.
//  Copyright © 2015 Itua Ijagbone. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, NMAMapViewDelegate, CLLocationManagerDelegate, NMARouteManagerDelegate {

    @IBOutlet var mapView: NMAMapView!
    @IBOutlet var address: UILabel!
    @IBOutlet var remainingTime: UILabel!
    @IBOutlet var notifyButton: UIButton!
    
    var previousAddress:String!;
    
    let locationManager = CLLocationManager()
    var geoCoder:CLGeocoder = CLGeocoder()
    var routeManager: NMARouteManager!;
    var timer:NSTimer!
    
    let libLat = 41.83368
    let libLong = -87.62831
    let herLat = 41.8355751
    let herLong = -87.6287047
    
    var carMarker:NMAMapObject!
    
    var bests = [NMARoute]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        timer = NSTimer()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.routeManager =  NMARouteManager.sharedRouteManager()
        self.routeManager.delegate = self
        if let location = self.locationManager.location {
            setUserLocationOnMap(location)
        } else {
            presentLocationAlertError()
        }
        
//        setBuildinglocations()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let loc = location {
            setUserLocationOnMap(loc)
        } else {
            presentLocationAlertError()
        }
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func setUserLocationOnMap(location: CLLocation) {
        var geoCoordCenter:NMAGeoCoordinates;
        geoCoordCenter = NMAGeoCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.mapView.setGeoCenter(geoCoordCenter, withAnimation: NMAMapAnimation.None)
        geoCode(location)
        renderMap()
    }
    
    func renderMap() {
        self.mapView.copyrightLogoPosition = NMALayoutPosition.BottomCenter;
        
        // set zoom level
//        self.mapView.zoomLevel = 13.2;
        
        // set indicator
        self.mapView.positionIndicator.visible = true
        self.mapView.positionIndicator.accuracyIndicatorVisible = true
        
        setBuildinglocations()
    }
    
    func presentLocationAlertError() {
        let alert = UIAlertController(title: "Loction Not Found", message: "Can't get your location", preferredStyle: .Alert)
        let firstAction = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alert.addAction(firstAction)
        presentViewController(alert, animated: true, completion: nil)
        
        var geoCoordCenter:NMAGeoCoordinates;
        geoCoordCenter = NMAGeoCoordinates(latitude: 49.279483, longitude: -123.115025)
        self.mapView.setGeoCenter(geoCoordCenter, withAnimation: NMAMapAnimation.None)
        let location = CLLocation(latitude: 49.279483, longitude: -123.115025)
        geoCode(location)
        renderMap()
    }
    
    func geoCode(location : CLLocation!){
        /* Only one reverse geocoding can be in progress at a time hence we need to cancel existing
        one if we are getting location updates */
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else {
                return
            }
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joinWithSeparator(", ")
            self.address.text = address
            self.previousAddress = address
        })
        
    }
    
    @IBAction func restoreLocation(sender: UIButton) {
        if let location = self.locationManager.location {
            setUserLocationOnMap(location)
        } else {
            presentLocationAlertError()
        }
    }
    
    func setBuildinglocations() {
        let mapContainer = NMAMapContainer()
        
        var building = NMAMapMarker.mapMarkerWithGeoCoordinates(NMAGeoCoordinates(latitude: 41.83368, longitude: -87.62831), image: UIImage(named: "destination.png")!)
        mapContainer.addMapObject(building as! NMAMapMarker)
        
        building = NMAMapMarker.mapMarkerWithGeoCoordinates(NMAGeoCoordinates(latitude: 41.8355751, longitude: -87.6287047), image: UIImage(named: "destination.png")!)
        mapContainer.addMapObject(building as! NMAMapMarker)
        
        self.mapView.addMapObject(mapContainer)
        
        calculateDistance(libLat, longBuilding: libLong)
    }
    
    func calculateDistance(latBuilding: Double, longBuilding: Double) {
        var stops = [AnyObject]()
        
        guard let location = self.locationManager.location else {
            presentLocationAlertError()
            return
        }
        
        print("%d - %d\n", location.coordinate.latitude, location.coordinate.longitude)
        
        let geoCord1 = NMAGeoCoordinates(latitude: latBuilding, longitude: longBuilding)
        let geoCord2 = NMAGeoCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        stops.append(geoCord1)
        stops.append(geoCord2)
        
        let routingMode = NMARoutingMode(routingType: .Fastest, transportMode: .Pedestrian, routingOptions: 0)
        
        routeManager.calculateRouteWithStops(stops, routingMode: routingMode)
        
    }
    
    func routeManager(routeManager: NMARouteManager!, didCalculateRoutes routes: [AnyObject]!, withError error: NMARouteManagerError, violatedOptions: [AnyObject]!) {
        if routes != nil {
            if bests.count < 2 {
                bests.append( routes[0] as! NMARoute)
                if bests.count < 2 {
                    calculateDistance(herLat, longBuilding: herLong)
                }
            }
            
            if bests.count == 2 {
                print("Got to count = 2")
                if bests[0].tta.duration > bests[1].tta.duration {
                    let mapRoute = NMAMapRoute(route: bests[1])
                    self.mapView.addMapObject(mapRoute)
                    self.remainingTime.text = "\(Int(bests[1].tta.duration/60)) min FROM PICKUP LOCATION"
                } else {
                    let mapRoute = NMAMapRoute(route: bests[0])
                    self.mapView.addMapObject(mapRoute)
                    self.remainingTime.text = "\(Int(bests[0].tta.duration/60)) min FROM PICKUP LOCATION"
                }
            }
//            let route = routes[0] as! NMARoute
//            print("%d - %d\n", route.tta.duration, route.length)
//            let mapRoute = NMAMapRoute(route: route)
//            self.mapView.addMapObject(mapRoute)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.LightContent
        
        //Default
        //return UIStatusBarStyle.Default
        
    }
    
    @IBAction func notifyServer(sender: UIButton) {
        if self.notifyButton.titleLabel?.text == "Notify" {
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector: Selector("getDriverUpdate"), userInfo: nil, repeats: true)
            self.notifyButton.setTitle("Notifying", forState: .Normal)
        } else {
            self.timer.invalidate()
            self.notifyButton.setTitle("Notify", forState: .Normal)
        }
    }
    
    func getDriverUpdate() {
        print("Debug")
        
        
        Alamofire.request(.GET, "http://52.33.122.72:2000/car_location").responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                let lat = Double(json["result"][0].stringValue)
                let long = Double(json["result"][1].stringValue)
                
                if lat! == 41.8345751 && long! == -87.6270952 {
                    self.timer.invalidate()
                    
                    let alert = UIAlertController(title: "Info", message: "Public Saftey Car is Here for Pick", preferredStyle: .Alert)
                    let firstAction = UIAlertAction(title: "ok", style: .Default) {
                        (alert: UIAlertAction!) -> Void in
                        self.notifyButton.setTitle("Notify", forState: .Normal)
                    }
                    alert.addAction(firstAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                if self.carMarker != nil {
                    self.mapView.removeMapObject(self.carMarker)
                    self.carMarker = NMAMapMarker.mapMarkerWithGeoCoordinates(NMAGeoCoordinates(latitude: lat!, longitude: long!), image: UIImage(named: "car.png")!) as! NMAMapMarker
                    self.mapView.addMapObject(self.carMarker as NMAMapObject)
                    self.notifyButton.setTitle("Cancel", forState: .Normal)
                } else {
                    self.carMarker = NMAMapMarker.mapMarkerWithGeoCoordinates(NMAGeoCoordinates(latitude: lat!, longitude: long!), image: UIImage(named: "car.png")!) as! NMAMapMarker
                    self.mapView.addMapObject(self.carMarker as NMAMapObject)
                    self.notifyButton.setTitle("Cancel", forState: .Normal)
                }
                print("\(lat) - \(long)")
            case .Failure(_):
                print("Request failed with error\n")
            }
        }
    }
    
    func restoreAll() {
        
    }
    
}

