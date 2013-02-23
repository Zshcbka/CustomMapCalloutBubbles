//
//  MultiRowCalloutCell.m
//  Created by Greg Combs on 11/29/11.
//
//  based on work at https://github.com/grgcombs/MultiRowCalloutAnnotationView
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. 
//  To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
//  or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
//
//

#import "MultiRowCalloutCell.h"
#import <QuartzCore/QuartzCore.h>

CGSize const kMultiRowCalloutCellSize = {270,48};

@interface MultiRowCalloutCell()
- (id)initWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle userData:(Content *)userData onCalloutAccessoryTapped:(MultiRowAccessoryTappedBlock)block;
- (IBAction)calloutAccessoryTapped:(id)sender;
@end

@implementation MultiRowCalloutCell
@synthesize userData = _userData;
@synthesize onCalloutAccessoryTapped = _onCalloutAccessoryTapped;

+ (MultiRowCalloutCell *)cellWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle userData:(Content *)userData onCalloutAccessoryTapped:(MultiRowAccessoryTappedBlock)block {
    return [[MultiRowCalloutCell alloc] initWithImage:image title:title subtitle:subtitle userData:userData onCalloutAccessoryTapped:block];
}

+ (MultiRowCalloutCell *)cellWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle userData:(Content *)userData {
    return [MultiRowCalloutCell cellWithImage:image title:title subtitle:subtitle userData:userData onCalloutAccessoryTapped:nil];
}

- (id)initWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle userData:(Content *)userData onCalloutAccessoryTapped:(MultiRowAccessoryTappedBlock)block {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (self) {
        self.onCalloutAccessoryTapped = block;
        self.title = title;
        self.subtitle = subtitle;
        self.image = image;
        self.userData = userData;
        self.opaque = YES;

        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIButton *accessory = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessory setImage:[UIImage imageNamed:@"arrow_white"] forState:UIControlStateNormal];
        accessory.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - 20, self.frame.origin.y + 10, 30, 32);
        accessory.enabled = YES;
        [accessory addTarget: self action:@selector(calloutAccessoryTapped:) forControlEvents: UIControlEventTouchUpInside || UIControlEventTouchDown];

        self.accessoryView = accessory;
        self.textLabel.backgroundColor = self.backgroundColor;
        self.textLabel.textColor = [UIColor colorWithRed:242/255.f green:245/255.f blue:226/255.f alpha:1];
        self.textLabel.font = [UIFont boldSystemFontOfSize:18];
        self.textLabel.shadowColor = [UIColor darkTextColor];
        self.textLabel.shadowOffset = CGSizeMake(0, 1);
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.detailTextLabel.textColor = [UIColor colorWithRed:242/255.f green:245/255.f blue:226/255.f alpha:1];
        self.detailTextLabel.font =	[UIFont boldSystemFontOfSize:14];
        self.detailTextLabel.numberOfLines = 2;
        self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        self.detailTextLabel.backgroundColor = self.backgroundColor;
        self.detailTextLabel.shadowColor = [UIColor darkTextColor];
        self.detailTextLabel.shadowOffset = CGSizeMake(0, -1);
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (IBAction)calloutAccessoryTapped:(id)sender {
    if (self.onCalloutAccessoryTapped)
        _onCalloutAccessoryTapped(self, sender, self.userData);
    UIAlertView *tapped = [[UIAlertView alloc] initWithTitle:@"MultiRowCalloutCell" message:@"User tapped button inside a row of callout bubble!" delegate:self cancelButtonTitle:@"Hoorey!" otherButtonTitles:nil, nil];
    [tapped show];
}

#pragma mark - Block setters

// NOTE: Sometimes see crashes when relying on just the copy property. Using Block_copy ensures correct behavior


#pragma mark - Convenience Accessors

- (UIImage *)image {
    
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    CGSize newSize = CGSizeMake(35 , 20);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = newImage;
}

- (NSString *)title {
    return self.textLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
}

- (NSString *)subtitle {
    return self.detailTextLabel.text;
}

- (void)setSubtitle:(NSString *)subtitle {
    self.detailTextLabel.text = subtitle;
}

@end

