//
//  ScaryBugData.h
//  mac
//
//  Created by Alp Yucebiligin on 2/20/14.
//  Copyright (c) 2014 Alp Yucebiligin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject

@property NSString *   title;
@property float        rating;

-(id) initWithTitle:(NSString*) title andRating:(float) rating;

@end
