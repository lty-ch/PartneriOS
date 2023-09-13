//
//  SearchLocationVC+Delegate.swift
//  AlSafi
//
//  Created by shashivendra sengar on 01/07/22.
//

import Foundation
import GooglePlaces
import UIKit

extension SearchYourLocationVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        autocompleteClicked()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //autocompleteClicked()
        return false
    }
    
}


//MARK: this extension for search places

extension SearchYourLocationVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //print("Place name: \(place.name)")
        // print("Place ID: \(place.placeID)")
        //print("Place attributions: \(place.attributions)")
        
        
        let locValue: CLLocationCoordinate2D = place.coordinate
        print("locations with lat & long = \(locValue.latitude) \(locValue.longitude) \(textFieldSearch.text ?? "")")
        
        
        self.lat = Double(place.coordinate.latitude)
        self.long = Double(place.coordinate.longitude)
        
        textFieldSearch.text = place.name
        textFieldSearch.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        // Use optional wrapping with fetched data
        setUPMapView(lat: self.lat ?? 0.0, long: self.long ?? 0.0, placeName: place.name ?? "Delhi")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
