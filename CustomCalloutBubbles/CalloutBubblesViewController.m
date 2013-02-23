//
//  CalloutBubblesViewController.m
//  CustomCalloutBubbles
//
//  Created by Zshcbka on 2/23/13.
//  Copyright (c) 2013 Zshcbka. All rights reserved.
//

#import "CalloutBubblesViewController.h"
#import "AnnotationViewProtocol.h"
#import "Content.h"
#import "Annotation.h"
#import "CalloutView.h"
#import "TableViewCallout.h"

@interface CalloutBubblesViewController ()
@end

@implementation CalloutBubblesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.delegate = self;
	
    
    Content *content = [Content new];
    Content *contentMult = [Content new];
    
    CLLocationCoordinate2D coordinate = {50.315, 30.2045};
    CLLocationCoordinate2D coordinateMult = {50.450, 30.3040};
    
    content.coordinate = coordinate;
    content.calloutView = [CalloutView class];
    content.iconURL = [[NSBundle mainBundle] URLForResource:@"Doggie" withExtension:@"png"];
    content.values = [NSDictionary dictionaryWithObjectsAndKeys:@"Orange", @"title", [UIImage imageNamed:@"Orange"], @"icon", nil];
    UIImage *img1 = [UIImage imageNamed:@"Saturn"];
    UIImage *img2 = [UIImage imageNamed:@"Uranus"];
    UIImage *img3 = [UIImage imageNamed:@"Venus"];
    NSDictionary *point1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Saturn", @"name", img1, @"icon", @"Some very imformative detail info with contacnts etc", @"subtitle", nil];
    NSDictionary *point2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Uranus", @"name", img2, @"icon",@"Some very imformative detail info with contacnts etc", @"subtitle", nil];
    NSDictionary *point3 = [NSDictionary dictionaryWithObjectsAndKeys:@"Venus", @"name", img3, @"icon",@"Some very imformative detail info with contacnts etc", @"subtitle", nil];
    
    contentMult.dataArray = [NSArray arrayWithObjects:point1,point2,point3, nil];
    contentMult.iconURL = [[NSBundle mainBundle] URLForResource:@"RedDog" withExtension:@"gif"];
    contentMult.calloutView = [TableViewCallout class];
    contentMult.coordinate = coordinateMult;
    Annotation *anno = [[Annotation alloc] initWithContent:content];
    Annotation *annoMult = [[Annotation alloc] initWithContent:contentMult];
    
    anno.mapView = self.mapView;
    annoMult.mapView = self.mapView;

    [self.mapView addAnnotation:anno];
    [self.mapView addAnnotation:annoMult];
	[self.mapView setRegion:MKCoordinateRegionMake(coordinate,
												   MKCoordinateSpanMake(1, 1))];
}

//Map view custom annotations
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // delegate the implementation to the annotation view
    if ([view conformsToProtocol:@protocol(AnnotationViewProtocol)]) {
        //debug(@"%@ conforms", NSStringFromClass([view class]));
        [((NSObject<AnnotationViewProtocol>*)view) didSelectAnnotationViewInMap:self.mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    // delegate the implementation to the annotation view
    if ([view conformsToProtocol:@protocol(AnnotationViewProtocol)]) {
        [((NSObject<AnnotationViewProtocol>*)view) didDeselectAnnotationViewInMap:self.mapView];
    }
}

#pragma mark - MKMapView Delegate
//id<MKAnnotation>
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    // if this is a custom annotation
    if ([annotation conformsToProtocol:@protocol(AnnotationProtocol)]) {
        
        // delegate the implementation to it
        return [((NSObject<AnnotationProtocol>*)annotation) annotationViewInMap:mapView];
    }
    
    else {
        
        // else, return a standard annotation view
        static NSString *viewId = @"MKPinAnnotationView";
        MKAnnotationView *view = (MKPinAnnotationView*) [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
        if (view == nil) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId];
        }
        view.canShowCallout = YES;
        return view;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
