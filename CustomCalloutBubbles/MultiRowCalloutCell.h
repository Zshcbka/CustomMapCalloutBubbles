//
//  MultiRowCalloutCell.h
//  Created by Greg Combs on 11/29/11.
//
//  based on work at https://github.com/grgcombs/MultiRowCalloutAnnotationView
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. 
//  To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
//  or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Content.h"

@class MultiRowCalloutCell;
typedef void(^MultiRowAccessoryTappedBlock)(MultiRowCalloutCell *cell, UIControl *control, Content *userData);

@interface MultiRowCalloutCell : UITableViewCell
@property (nonatomic,retain) Content *userData;
@property (nonatomic,copy) MultiRowAccessoryTappedBlock onCalloutAccessoryTapped;
@property (nonatomic,assign) NSString *title;
@property (nonatomic,assign) NSString *subtitle;
@property (nonatomic,assign) UIImage *image;
+ (MultiRowCalloutCell *)cellWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle userData:(Content *)userData;
+ (MultiRowCalloutCell *)cellWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle userData:(Content *)userData onCalloutAccessoryTapped:(MultiRowAccessoryTappedBlock)block;
@end

extern CGSize const kMultiRowCalloutCellSize;