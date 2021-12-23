//
//  MapViewController.h
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic) CGFloat lat;
@property (nonatomic) CGFloat lng;
@property (nonatomic, strong) NSString *schoolName;

@end

NS_ASSUME_NONNULL_END
