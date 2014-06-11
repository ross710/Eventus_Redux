//
//  Shared.m
//  Eventus_Redux
//
//  Created by Ross Tang Him on 6/10/14.
//  Copyright (c) 2014 Eventus. All rights reserved.
//

#import "Shared.h"

@implementation Shared

+(UIColor *) dayColor {
    return [UIColor colorWithRed:255.0f/255 green:204.0f/255 blue:0.0f/255 alpha:1.0f];
}

+(UIColor *) nightColor {
    return [UIColor colorWithRed:0.0f/255 green:51.0f/255 blue:102.0f/255 alpha:1.0f];
}

+(UIColor *) textColor {
    return [UIColor whiteColor];
}

+(UIColor *) backgroundColor {
    if ([self isDay]) {
        return [self dayColor];
    } else {
        return [self nightColor];
    }
}

+(BOOL) isDay {
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit)
                                                  fromDate: [NSDate date]];
    NSInteger hour = [dateComps hour];
    if (hour > 4 && hour < 18) {
        return YES;
    } else {
        return NO;
    }
}

@end
