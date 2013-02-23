//
//  TableViewCallout.m
//  
//
//  Created by Zshcbka on 2/23/13.
//  Copyright (c) 2013 Zshcbka. All rights reserved.
//

#import "TableViewCallout.h"
#import "CalloutAnnotation.h"
#import "MultiRowCalloutCell.h"

#define CalloutMapAnnotationViewBottomShadowBufferSize 6.0f
#define CalloutMapAnnotationViewContentHeightBuffer 8.0f
#define CalloutMapAnnotationViewHeightAboveParent 2.0f
CGFloat const MultiRowCalloutCellGap = 3;
@implementation TableViewCallout


-(IBAction) handleTouch:(id)sender {
    //debug(@"touch %@", sender);
}

- (id)initWithAnnotation:(CalloutAnnotation*)annotation
{
    //we set _contentView for Base Callout View to calculate map pin location and height
    super.contentView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 220, 103)];
    NSString *identifier = NSStringFromClass([self class]);
    self = [super initWithAnnotation:annotation reuseIdentifier:identifier];
    if (self!=nil){
        // prevent the tap and double tap from reaching views underneath
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        UITapGestureRecognizer *doubletapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
        doubletapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubletapGestureRecognizer];
        self.cellInsetX = 5;
        self.cellOffsetY = 10;
    }
   
    self.data = annotation.content.dataArray;
    self.frame = CGRectMake( 0, 0, 270, 172);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.cellInsetX , self.cellOffsetY, kMultiRowCalloutCellSize.width -  2*self.cellInsetX , 128)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    return self;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
    
}

 - (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultiRowCalloutCell";
    
     MultiRowCalloutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [MultiRowCalloutCell cellWithImage:[[self.data objectAtIndex:indexPath.row] objectForKey:@"icon"] title:[[self.data objectAtIndex:indexPath.row] objectForKey:@"name"] subtitle:[[self.data objectAtIndex:indexPath.row] objectForKey:@"subtitle"] userData:nil onCalloutAccessoryTapped:^(MultiRowCalloutCell *cell, UIControl *control, Content *userData) {
            
        }];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertView *tapped = [[UIAlertView alloc] initWithTitle:@"TableViewCalloutCell" message:@"User tapped button inside a row of callout bubble!" delegate:self cancelButtonTitle:@"Hoorey!" otherButtonTitles:nil, nil];
    [tapped show];
}

// fixes bug in iOS 6 that displays custom annotations behind map annotations
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self.superview bringSubviewToFront:self];
}


@end
