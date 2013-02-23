
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "AnnotationView.h"
#import "CalloutAnnotation.h"
#import "CalloutView.h"

@implementation CalloutAnnotation

@synthesize parentAnnotationView = _parentAnnotationView;
@synthesize mapView = _mapView;
@synthesize content = _content;
@synthesize coordinate = _coordinate;
@synthesize calloutView = _calloutView;


- (MKAnnotationView*)annotationViewInMap:(MKMapView *)aMapView;
{
    Class calloutViewClass = self.content.calloutView;
    
    // dequeue or create a MKAnnotationView
    if (self.calloutView==nil) {
        NSString *identifier = NSStringFromClass(calloutViewClass);
        self.calloutView = (BaseCalloutView*)[aMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        self.calloutView.mapView = self.mapView;
        if (self.calloutView==nil)
            self.calloutView = [[calloutViewClass alloc] initWithAnnotation:self];
        
    } else {
        self.calloutView.annotation = self;
    }
    self.calloutView.parentAnnotationView = self.parentAnnotationView;
    self.calloutView.mapView = self.mapView;
    return self.calloutView;
}


#pragma mark - accessors

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
    if (self.calloutView) {
        [self.calloutView setAnnotation:self];
    }
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}


#pragma mark - NSObject

/** Init with a coordinate. */
- (id) initWithContent:(Content*)content
{
    self = [super init]; 
    if (self){
        self.content = content;
        self.coordinate = content.coordinate;
        self.calloutView = nil;   
    }
    return self;
}


@end
