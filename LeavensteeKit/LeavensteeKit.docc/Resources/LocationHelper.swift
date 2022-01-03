//
//  LocationHelper.swift
//  IsItShittyOut
//
//  Created by Steven Lee on 2/4/21.
//
import CoreLocation
import MapKit

@available(iOS 13.0, *)
public final class LocationHelper: ObservableObject {
    @Published public var locationManager = CLLocationManager()
    @Published public var currentLocation: CLLocation?
    @Published public var placemark: CLPlacemark?
    @Published public var region: MKCoordinateRegion?
    
    public init() {}
    
    public var isLocationAuthorized: Bool {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways
        } else {
            return false
        }
    }
    
    public func requestAuthoriization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func getLocation(completion: @escaping (Bool) -> Void) {
        if(isLocationAuthorized) {
            guard let location = locationManager.location else { return }
            currentLocation = location
            region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            lookUpCurrentLocation { [weak self] placemark in
                self?.placemark = placemark
                completion(true)
            }
        }
        
    }
    
    public func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}
