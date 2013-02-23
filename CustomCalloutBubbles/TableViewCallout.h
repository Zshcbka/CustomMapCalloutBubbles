//
//  TableViewCallout.h
//  
//
//  Created by Zshcbka on 2/23/13.
//  Copyright (c) 2013 Zshcbka. All rights reserved.
//

#import "BaseCalloutView.h"

@interface TableViewCallout : BaseCalloutView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic,assign) CGFloat cellInsetX;
@property (nonatomic,assign) CGFloat cellOffsetY;

@end
