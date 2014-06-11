//
//  MapViewController.h
//  Eventus_Redux
//
//  Created by Ross Tang Him on 6/10/14.
//  Copyright (c) 2014 Eventus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewController : UIViewController<CLLocationManagerDelegate, UITextFieldDelegate> {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocation *myLocation;
}
@end
