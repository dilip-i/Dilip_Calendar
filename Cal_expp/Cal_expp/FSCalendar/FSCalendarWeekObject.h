//
//  FSCalendarWeekObject.h
//  Cal_expp
//
//  Created by Dilip Indpro on 14/01/18.
//  Copyright © 2018 Dilip Indpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSCalendarWeekObject : NSObject

@property (nonatomic) NSInteger week;
@property (nonatomic) NSInteger yr;

-(FSCalendarWeekObject*)initWithWeekno:(NSInteger)no yr:(NSInteger)year;

@end
