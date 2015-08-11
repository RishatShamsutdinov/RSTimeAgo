//
//  RSTimeAgo.h
//  RSTimeAgo
//
//  Created by rishat on 11.08.15.
//  Copyright (c) 2015 rishat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RSTimeAgoUnitMinutes,
    RSTimeAgoUnitHours,
    RSTimeAgoUnitDays,
    RSTimeAgoUnitWeeks,
    RSTimeAgoUnitMonths,
    RSTimeAgoUnitYears
} RSTimeAgoUnit;

@interface RSTimeAgo : NSObject

@property (nonatomic, readonly) NSInteger value;
@property (nonatomic, readonly) RSTimeAgoUnit valueUnit;
@property (nonatomic, readonly) NSTimeInterval rawValue;

+ (instancetype)timeAgoSinceDate:(NSDate *)date;
+ (instancetype)timeAgoSinceDate:(NSDate *)sinceDate untilDate:(NSDate *)untilDate;

+ (instancetype)timeAgoSinceUnixtime:(int32_t)unixtime;
+ (instancetype)timeAgoSinceUnixtime:(int32_t)sinceUnixtime untilUnixtime:(int32_t)untilUnixtime;

+ (instancetype)timeAgoSinceTimeInterval:(NSTimeInterval)sinceTimeInterval
                       untilTimeInterval:(NSTimeInterval)untilTimeInterval;

- (instancetype)initWithSinceTimeInterval:(NSTimeInterval)sinceTimeInterval
                        untilTimeInterval:(NSTimeInterval)untilTimeInterval;

@end
