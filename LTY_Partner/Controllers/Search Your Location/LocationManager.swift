//
//  LocationManager.swift
//  AlSafi
//
//  Created by shashivendra sengar on 27/06/22.
//

import Foundation
import CoreLocation
import GoogleMaps

enum LocationStatus{
    case requestAuthorization
    case authorizationChanged
}
protocol LocationManagerDelegate {
    func fetchLocation(location : CLLocation,placemark:String)
    func accessDenied()
    func accessRestricted()
    func locationServiceDisabled()
    
    
}

final class LocationManager : NSObject {
    var locationManager : CLLocationManager?
    var location : CLLocation?
    // var address: AddressInfo?
    var delegate : LocationManagerDelegate?
    static let sharedInstance   =   LocationManager()
    var locationName:String?
    
    fileprivate override init(){
        
    }
    private func initLocation(){
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager?.delegate = self
        getLocation(locationStatus: .requestAuthorization)
        //location = CLLocation(latitude: 21.508907, longitude: 39.185955)
        //address = AddressInfo(name: "Makkah Al Mukarramah Province", street: "Al Sharafiah", city: "Jeddah", country: "Saudi Arabia")
    }
    func getCurrentLocation(){
        getLocation(locationStatus: .requestAuthorization)
    }
    private func startUpdatingLocation() {
        print("Starting Location Updates")
        locationManager?.startUpdatingLocation()
    }
    private func startUpdatingHeading() {
        print("Starting Location Updates")
        locationManager?.startUpdatingHeading()
    }
    private func stopUpdatingLocation() {
        print("Stop Location Updates")
        locationManager?.stopUpdatingLocation()
    }
    func checkToRequestLocation(_ forcefully: Bool){
        if locationManager == nil {
            print("Location init")
            initLocation()
        }else{
            
           // initLocation()

            print("Location already running")
            if forcefully {
                getLocation(locationStatus: .requestAuthorization)
            }
        }
    }
    func getLocation(locationStatus: LocationStatus){
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                let status = CLLocationManager.authorizationStatus()
                self.authorizationStatus(status: status, locationStatus: locationStatus)
            }
            else {
                self.delegate?.locationServiceDisabled()
                print("Location Service Disabled.")
            }
        }
      
    }
    
    func authorizationStatus(status: CLAuthorizationStatus, locationStatus: LocationStatus){
        
        switch status {
            
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager?.startUpdatingLocation()
            //locationManager?.startUpdatingHeading()
            print("authorizedWhenInUse")
            
        case .denied:
            delegate?.accessDenied()
            //
          //  self.checkLocation()
           // DisplayBanner.show(title: "Location access Denied.")
            print("denied")
        case .restricted:
            print("restricted")
            delegate?.accessRestricted()
            
            print("Location restricted.")
        @unknown default: break
            
        }
        print("statusCase \(locationStatus)")
    }
    
        
}
// CLLocationManagerDelegate
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        
        if let location = locations.last {
            self.location = location
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if (error != nil){
                    print("error in reverseGeocode")
                }
                let placemark = placemarks! as [CLPlacemark]
                if placemark.count>0{
                    let placemark = placemarks![0]
                    print(placemark.locality!)
                    print(placemark.administrativeArea!)
                    print(placemark.country!)
                    self.locationName = "\(placemark.subLocality!),\(placemark.locality!),\(placemark.administrativeArea!),\(placemark.postalCode!)"
                    self.delegate?.fetchLocation(location: location, placemark:self.locationName ?? "")
                }
            }
            
            print(location.coordinate.latitude)
        }
        
        
        stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError")
        stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        getLocation(locationStatus: .authorizationChanged)
    }
    
}
//extension LocationManager {
//    class func getCoordinate(from address: String, result: @escaping (Result<Any>) -> ()) {
//        let geoCoder = CLGeocoder()
//        geoCoder.geocodeAddressString(address) { (placemarks, error) in
//            if error != nil {
//                result(Result.failure(error))
//                return
//            }
//            guard
//                let placemarks = placemarks,
//                let location = placemarks.first?.location
//            else {
//                result(Result.failure(error))
//                return
//            }
//            result(Result.success(location))
//            
//        }
//    }
//}


