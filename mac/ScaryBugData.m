//
//  ScaryBugData.m
//  mac
//
//  Created by Alp Yucebiligin on 2/20/14.
//  Copyright (c) 2014 Alp Yucebiligin. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

-(id) initWithTitle:(NSString*) title andRating:(float) rating
{
    self = [super init];
    if ( self ) {
        self.title  = title;
        self.rating = rating;
    }
    return self;
}

@end
