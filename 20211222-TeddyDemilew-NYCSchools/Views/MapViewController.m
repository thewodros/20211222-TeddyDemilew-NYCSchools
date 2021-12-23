//
//  MapViewController.m
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // set title of navBar with the school name
    self.title = self.schoolName;

    // set region
    CLLocationCoordinate2D coordinate = {.latitude = self.lat, .longitude = self.lng}; //CLLocationCoordinate2DMake(self.lat, self.lng);
    MKCoordinateSpan span = {.latitudeDelta = 0.050f, .longitudeDelta = 0.050f};
    MKCoordinateRegion region = {coordinate, span};

    [self.mapView setRegion:region];
    
    // drop pin at school location
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [annotation setTitle:self.schoolName];
    [self.mapView addAnnotation:annotation];
}

@end
