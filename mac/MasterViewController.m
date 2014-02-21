//
//  MasterViewController.m
//  mac
//
//  Created by Alp Yucebiligin on 2/20/14.
//  Copyright (c) 2014 Alp Yucebiligin. All rights reserved.
//

#import "MasterViewController.h"
#import "ScaryBugDoc.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView * cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if ([tableColumn.identifier isEqualToString:@"bugColumn"])
    {
        cellView.imageView.image = ((ScaryBugDoc*)[self.bugs objectAtIndex:row]).thumbImage;
        cellView.textField.stringValue = ((ScaryBugDoc*)[self.bugs objectAtIndex:row]).data.title;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.bugs count];
}

@end
