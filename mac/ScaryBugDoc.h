//
//  ScaryBugDoc.h
//  mac
//
//  Created by Alp Yucebiligin on 2/20/14.
//  Copyright (c) 2014 Alp Yucebiligin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScaryBugData.h"

@interface ScaryBugDoc : NSObject

@property ScaryBugData * data;
@property NSImage *thumbImage;
@property NSImage *fullImage;

- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage;
@end
