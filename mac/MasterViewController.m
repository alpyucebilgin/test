//
//  MasterViewController.m
//  mac
//
//  Created by Alp Yucebiligin on 2/20/14.
//  Copyright (c) 2014 Alp Yucebiligin. All rights reserved.
//

#import "MasterViewController.h"
#import "ScaryBugDoc.h"
#import "EDStarRating.h"
#import <Quartz/Quartz.h>
#import "NSImage+Extras.h"

@interface MasterViewController ()
@property (weak) IBOutlet NSTableView *bugsTableView;
@property (weak) IBOutlet EDStarRating *bugRatingView;
@property (weak) IBOutlet NSImageView *bugsImageView;
@property (weak) IBOutlet NSTextField *bugsTextField;

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

-(void) loadView
{
    [super loadView];
    self.bugRatingView.starHighlightedImage = [NSImage imageNamed:@"shockedface2_full.png"];
    self.bugRatingView.starImage = [NSImage imageNamed:@"shockedface2_empty.png"];
    self.bugRatingView.maxRating = 5.0;
    self.bugRatingView.delegate = (id<EDStarRatingProtocol>) self;
    self.bugRatingView.editable = YES;
    self.bugRatingView.displayMode = EDStarRatingDisplayFull;
    self.bugRatingView.rating = 0;
}

- (IBAction)addBug:(id)sender
{
    ScaryBugDoc * newBug = [[ScaryBugDoc alloc] initWithTitle:@"New Bug" rating:0.0 thumbImage:nil fullImage:nil];
    [self.bugs addObject:newBug];
    NSInteger newRowIndex = self.bugs.count - 1;
    [self.bugsTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] withAnimation:NSTableViewAnimationEffectGap];
    [self.bugsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
    [self.bugsTableView scrollColumnToVisible:newRowIndex];
}

- (IBAction)removeBug:(id)sender
{
    NSInteger selectedIndex = self.bugsTableView.selectedRow;
    [self.bugs removeObjectAtIndex:selectedIndex];
    [self.bugsTableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:selectedIndex] withAnimation:NSTableViewAnimationEffectFade];
    NSInteger nextIndex = (selectedIndex <= self.bugs.count - 1) ? selectedIndex : selectedIndex - 1;
    [self.bugsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:nextIndex] byExtendingSelection:NO];
}

-(ScaryBugDoc*) selectedBugDoc
{
    NSInteger selectedRow = self.bugsTableView.selectedRow;
    if ( selectedRow >= 0 && selectedRow < self.bugs.count )
    {
        ScaryBugDoc *selectedBug = [self.bugs objectAtIndex:selectedRow];
        return selectedBug;
    }
    return nil;
}

-(void)pictureTakerDidEnd:(IKPictureTaker*) picker returnCode:(NSInteger) code contextInfo:(void*) contextInfo
{
    NSImage * selectedImage = [picker outputImage];
    if (selectedImage != nil && code == NSOKButton)
    {
        [self.bugsImageView setImage:selectedImage];
        ScaryBugDoc * bug = [self selectedBugDoc];
        if (bug != nil)
        {
            bug.fullImage = selectedImage;
            bug.thumbImage = [selectedImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
            NSIndexSet * indexSetRow = [NSIndexSet indexSetWithIndex:[self.bugs indexOfObject:bug]];
            NSIndexSet * indexSetCol = [NSIndexSet indexSetWithIndex:0];
            [self.bugsTableView reloadDataForRowIndexes:indexSetRow columnIndexes:indexSetCol];
        }
    }
}

- (IBAction)changePicture:(id)sender
{
    ScaryBugDoc * selectedDoc = [self selectedBugDoc];
    if (selectedDoc != nil)
    {
        [[IKPictureTaker pictureTaker] beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }
}

- (IBAction)changeName:(id)sender
{
    ScaryBugDoc * doc = [self selectedBugDoc];
    if (doc != nil)
    {
        doc.data.title = self.bugsTextField.stringValue;
        [self.bugsTableView reloadData];
    }
}

-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating
{
    ScaryBugDoc * doc = [self selectedBugDoc];
    if (doc != nil)
    {
        doc.data.rating = rating;
        [self.bugsTableView reloadData];        
    }
}

-(void) setDetailInfo:(ScaryBugDoc*) doc
{
    NSString * title = @"";
    NSImage * image = nil;
    float rating = 0.0;
    if (doc != nil)
    {
        title = doc.data.title;
        image = doc.fullImage;
        rating = doc.data.rating;
    }
    self.bugsTextField.stringValue = title;
    self.bugsImageView.image = image;
    [self.bugRatingView setRating:rating];
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    ScaryBugDoc * doc = [self selectedBugDoc];
    [self setDetailInfo:doc];
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
