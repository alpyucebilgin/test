//
//  MasterViewController.h
//  mac
//
//  Created by Alp Yucebiligin on 2/20/14.
//  Copyright (c) 2014 Alp Yucebiligin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MasterViewController : NSViewController <NSTableViewDataSource,NSTableViewDelegate>
@property NSMutableArray * bugs;
@end
