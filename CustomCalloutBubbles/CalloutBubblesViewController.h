//
//  CalloutBubblesViewController.h
//  CustomCalloutBubbles
//
//  Created by Zshcbka on 2/23/13.
//  Copyright (c) 2013 Zshcbka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AnnotationProtocol.h"
#import "AnnotationViewProtocol.h"

@interface CalloutBubblesViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@end
