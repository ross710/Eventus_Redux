//
//  MapViewController.m
//  Eventus_Redux
//
//  Created by Ross Tang Him on 6/10/14.
//  Copyright (c) 2014 Eventus. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Shared.h"
#import <QuartzCore/QuartzCore.h>


@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //add filter button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:nil];
    
    
    [self initMap];
    [self initLocation];

    
    // Do any additional setup after loading the view.
}

-(void) initLocation {
    UITextField *location = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 30)]; //come back to this
    location.text = @"Acquiring Location ...";
    location.placeholder = @"Enter a location";
    location.textColor = self.navigationController.navigationBar.tintColor;

    //put a line underneath the location
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = self.navigationController.navigationBar.tintColor.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0f, location.frame.size.height - 1.0f, location.frame.size.width, 1.0f);
    [location.layer addSublayer: bottomBorder];
    location.delegate = self;
    
    self.navigationItem.titleView = location;

    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    locationManager.delegate = self;
    geocoder = [[CLGeocoder alloc] init];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locationManager stopUpdatingLocation];
    myLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:myLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            UITextField *title = (UITextField *)self.navigationItem.titleView;
            [title setText:[NSString stringWithFormat:@"%@, %@",
                            placemark.locality,
                            placemark.administrativeArea]];
            [self resetToUserLocation];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

-(void) resetToUserLocation {
    //goto user location
    MKMapView *mapView = (MKMapView*)self.view;
    
    //get radius in miles
    CGFloat radius = 5.0f;
    // source: http://www.google.com/search?q=1+mile+in+meters
    [mapView setRegion: MKCoordinateRegionMakeWithDistance(myLocation.coordinate,
                                                        1609.344f * radius,
                                                           1609.344f * radius)
              animated:YES];
}

-(void) initMap {
    MKMapView *mapView = [[MKMapView alloc] init];
    mapView.showsUserLocation = YES;
    self.view = mapView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reset"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(resetToUserLocation)];
}

//uitextfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        [geocoder reverseGeocodeLocation:myLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                
                UITextField *title = (UITextField *)self.navigationItem.titleView;
                [title setText:[NSString stringWithFormat:@"%@, %@",
                                placemark.locality,
                                placemark.administrativeArea]];
            } else {
            }
        }];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
