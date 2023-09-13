//
//  SearchYourLocationVC.swift
//  Safi
//
//  Created by RAVI K GUPTA on 09/05/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol passCurrentLocation {
    func passLocationData(lat:Double,lang:Double ,address: String)
}

class SearchYourLocationVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var viewBackgroundHeader: UIView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var viewBackgroundSearchLocation: UIView!
    @IBOutlet weak var viewBackgroundSearch: UIView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet  var mapView: GMSMapView!
    @IBOutlet weak var buttonSetMyLocation: UIButton!
    
    //MARK: Properties
    
    var marker = GMSMarker()
    var lat : Double?
    var long :Double?
    var delegate : passCurrentLocation?
    var checkValue = ""
    let locationManager = CLLocationManager()//for enable current location
    
    //MARK: view life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupApperance()
        setupBackData()
        mapView.delegate = self
        textFieldSearch.delegate = self
        
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.checkToRequestLocation(true)
        //  makeButton()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttonSetMyLocation.layer.cornerRadius = 8
        viewBackgroundSearch.layer.cornerRadius = viewBackgroundSearch.frame.height/2
        //  viewBackgroundSearchLocation.setRadius(viewBackgroundSearchLocation.frame.height/2)
       // viewBackgroundHeader.setGradientLinearTopToBottom(colors: [Asset.Colors.blueColor.color, Asset.Colors.blackColor.color])
    }
    
    //MARK: setup ui func
    
    func setupApperance() {
        
        viewBackgroundHeader.roundCorners([.bottomLeft, .bottomRight], radius: 20)
      //  UIFont(name:"Helvetica",size:16)
//        buttonSetMyLocation.style(fontType:"Helvetica", fontSize: FontSize.size16, textColor: Asset.Colors.whiteColor,backgroundColor:Asset.Colors.redColor)
        buttonSetMyLocation.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        buttonSetMyLocation.backgroundColor = .red
//        buttonSetMyLocation.setShadow(radius: 3)
//        buttonSetMyLocation.setBottomShadow(radius:5)
        textFieldSearch.placeholder = "Search your location".localized()
    }
    
    //MARK: set back button place using localization
    
    func setupBackData() {
        
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            
            buttonBack.setImage(UIImage(named: "BackArrowWhite")?.withHorizontallyFlippedOrientation(), for: .normal)
            
        } else {
            
            buttonBack.setImage(UIImage(named: "BackArrowWhite"), for: .normal)
        }
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        
        (checkValue == "true") ? (self.dismiss(animated: true)) : (popViewController())

    }
    
    // MARK: Set Loctaion Action button func
    
    
    @IBAction func buttonSetMyLocationTapped(_ sender: UIButton) {
        
        if let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate  {
            
            print("locations with lat & long = \(locValue.latitude) \(locValue.longitude) \(textFieldSearch.text ?? "")")
            delegate?.passLocationData(lat: locValue.latitude, lang: locValue.longitude, address: textFieldSearch.text ?? "")
        }

        (checkValue == "true") ? (self.dismiss(animated: true)) : (popViewController())
    }
    
    //MARK: set current lang and lat func
    
    func setUPMapView(lat:Double , long:Double , placeName:String) {
        
        mapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude:lat, longitude:long, zoom: 16.0)
        self.mapView.settings.myLocationButton = true
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat,long)
        marker.icon = UIImage(named: "marker")
        // marker.title = placeName.localized()
        marker.snippet = placeName
        marker.map = mapView
        // textFieldSearch.text = locationName
        
    }
    
    func autocompleteClicked() {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
}

//MARK: this extension use for LocationManagerDelegate


extension SearchYourLocationVC : LocationManagerDelegate {
    
    func fetchLocation(location: CLLocation, placemark: String) {
        let latitude = location.coordinate.latitude
        let logitude = location.coordinate.longitude
        setUPMapView(lat: latitude, long: logitude, placeName
                     : placemark)
        textFieldSearch.text = placemark.localized()
    }
    
    func accessDenied() {
        checkLocation()
        
    }
    
    func accessRestricted() {
        
    }
    
    func locationServiceDisabled() {
        
    }
    
}

//MARK: this extension use for GMSMapViewDelegate

extension SearchYourLocationVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    
    //Convert the location position to address
    func returnPostionOfMapView(mapView:GMSMapView){
        let geocoder = GMSGeocoder()
        let latitute = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        let position = CLLocationCoordinate2DMake(latitute, longitude)
        geocoder.reverseGeocodeCoordinate(position) { response , error in
            if error != nil {
                print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
            }else {
                let result = response?.results()?.first
                let address = result?.lines?.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
                self.textFieldSearch.text = address?.localized()
                self.marker.title = address?.localized()
                self.setUPMapView(lat: latitute, long: longitude, placeName: address ?? "Location not Found".localized())
                
            }
        }
    }
}

//MARK: this extension use for check location have permision or not given by user


extension SearchYourLocationVC  {
    
    func checkLocation() {
        if CLLocationManager.locationServicesEnabled() {
               switch CLLocationManager.authorizationStatus() {
               case .notDetermined, .restricted, .denied:
                   showPermissionAlert()
               case .authorizedAlways, .authorizedWhenInUse:
                   locationManager.startUpdatingLocation()
               }
           } else {
               locationManager.startUpdatingLocation()
           }
    }
    
    
    func showPermissionAlert(){
      let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)

      let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
          //Redirect to Settings app
          UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
      })

      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
      alertController.addAction(cancelAction)
     
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
        
  }
}


