//
//  FSCalendarWeekObject.m
//  Cal_expp
//
//  Created by Dilip Indpro on 14/01/18.
//  Copyright © 2018 Dilip Indpro. All rights reserved.
//

#import "FSCalendarWeekObject.h"

@implementation FSCalendarWeekObject

-(FSCalendarWeekObject*)initWithWeekno:(NSInteger)no yr:(NSInteger)year{
    if(self = [super init]){
        self.week = no;
        self.yr = year;
        return self;
    }
    return nil;
}

@end
