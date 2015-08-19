/**
 *
 * Copyright 2015 Rishat Shamsutdinov
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import "RSTimeAgo.h"

#import <time.h>

#define RS_NUM_SEC_PER_MINUTE 60
#define RS_NUM_SEC_PER_HOUR (RS_NUM_SEC_PER_MINUTE * 60)
#define RS_NUM_SEC_PER_DAY (RS_NUM_SEC_PER_HOUR * 24)
#define RS_NUM_SEC_PER_WEEK (RS_NUM_SEC_PER_DAY * 7)

static uint const kMonthsPerYear = 12;

@implementation RSTimeAgo

+ (instancetype)timeAgoSinceDate:(NSDate *)date {
    return [self timeAgoSinceDate:date untilDate:[NSDate date]];
}

+ (instancetype)timeAgoSinceDate:(NSDate *)sinceDate untilDate:(NSDate *)untilDate {
    return [self timeAgoSinceTimeInterval:[sinceDate timeIntervalSinceReferenceDate]
                        untilTimeInterval:[untilDate timeIntervalSinceReferenceDate]];
}

+ (instancetype)timeAgoSinceUnixtime:(int32_t)unixtime {
    return [self timeAgoSinceUnixtime:unixtime untilUnixtime:[[NSDate date] timeIntervalSince1970]];
}

+ (instancetype)timeAgoSinceUnixtime:(int32_t)sinceUnixtime untilUnixtime:(int32_t)untilUnixtime {
    return [self timeAgoSinceTimeInterval:sinceUnixtime untilTimeInterval:untilUnixtime];
}

+ (instancetype)timeAgoSinceTimeInterval:(NSTimeInterval)sinceTimeInterval
                       untilTimeInterval:(NSTimeInterval)untilTimeInterval
{
    return [[self alloc] initWithSinceTimeInterval:sinceTimeInterval untilTimeInterval:untilTimeInterval];
}

static int _absMonthDiff(struct tm *sinceTmPtr, struct tm *untilTmPtr) {
    struct tm sinceTm = *sinceTmPtr;
    struct tm untilTm = *untilTmPtr;

    int monthDiff = (untilTm.tm_mon - sinceTm.tm_mon);
    int yearDiff = (untilTm.tm_year - sinceTm.tm_year);

    return (monthDiff + yearDiff * kMonthsPerYear);
}

static RSTimeAgoUnit _timeAgoUnitForSeconds(NSTimeInterval sinceTimeInterval, NSTimeInterval untilTimeInterval,
                                            struct tm *sinceTmPtr, struct tm *untilTmPtr)
{
    NSTimeInterval secondsAgo = (untilTimeInterval - sinceTimeInterval);

    if (secondsAgo < RS_NUM_SEC_PER_HOUR) {
        return RSTimeAgoUnitMinutes;
    } else if (secondsAgo < RS_NUM_SEC_PER_DAY) {
        return RSTimeAgoUnitHours;
    } else if (secondsAgo < RS_NUM_SEC_PER_WEEK) {
        return RSTimeAgoUnitDays;
    }

    time_t since = (typeof(since))sinceTimeInterval;
    time_t until = (typeof(until))untilTimeInterval;

    struct tm sinceTm, untilTm;

    localtime_r(&since, &sinceTm);
    localtime_r(&until, &untilTm);

    int mDayDiff = (untilTm.tm_mday - sinceTm.tm_mday);
    int absMonthDiff = _absMonthDiff(&sinceTm, &untilTm);

    if (absMonthDiff == 0 || (mDayDiff < 0 && absMonthDiff == 1)) {
        return RSTimeAgoUnitWeeks;
    }

    *sinceTmPtr = sinceTm;
    *untilTmPtr = untilTm;

    if (absMonthDiff < kMonthsPerYear) {
        return RSTimeAgoUnitMonths;
    }

    return RSTimeAgoUnitYears;
}

static NSInteger _unitValueForSeconds(NSTimeInterval secondsAgo, RSTimeAgoUnit unit,
                                      struct tm *sinceTmPtr, struct tm *untilTmPtr)
{
    switch (unit) {
        case RSTimeAgoUnitMinutes: return (NSInteger) (secondsAgo / RS_NUM_SEC_PER_MINUTE);
        case RSTimeAgoUnitHours: return (NSInteger) (secondsAgo / RS_NUM_SEC_PER_HOUR);
        case RSTimeAgoUnitDays: return (NSInteger) (secondsAgo / RS_NUM_SEC_PER_DAY);
        case RSTimeAgoUnitWeeks: return (NSInteger) (secondsAgo / RS_NUM_SEC_PER_WEEK);
        case RSTimeAgoUnitMonths: return (NSInteger) _absMonthDiff(sinceTmPtr, untilTmPtr);
        case RSTimeAgoUnitYears: return (NSInteger) (_absMonthDiff(sinceTmPtr, untilTmPtr) / kMonthsPerYear);
    }
}

- (instancetype)initWithSinceTimeInterval:(NSTimeInterval)sinceTimeInterval
                        untilTimeInterval:(NSTimeInterval)untilTimeInterval
{
    if (self = [super init]) {
        _rawValue = (untilTimeInterval - sinceTimeInterval);

        struct tm sinceTm, untilTm;

        _valueUnit = _timeAgoUnitForSeconds(sinceTimeInterval, untilTimeInterval, &sinceTm, &untilTm);
        _value = _unitValueForSeconds(_rawValue, _valueUnit, &sinceTm, &untilTm);
    }

    return self;
}

@end
