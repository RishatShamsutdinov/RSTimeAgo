//
//  Tests.m
//  RSTimeAgo
//
//  Created by rishat on 19.08.15.
//  Copyright (c) 2015 rishat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RSTimeAgo.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)testSameMonthWeeks {
    int const sinceTime = 666230400; // 11.02.1991
    int const untilTime = 667267200; // 23.02.1991

    RSTimeAgo *timeAgo = [RSTimeAgo timeAgoSinceUnixtime:sinceTime untilUnixtime:untilTime];

    XCTAssertEqual(timeAgo.valueUnit, RSTimeAgoUnitWeeks);
    XCTAssertEqual(timeAgo.value, 1);
}

- (void)testPrevMonthWeeks {
    int const sinceTime = 666230400; // 11.02.1991
    int const untilTime = 668304000; // 7.03.1991

    RSTimeAgo *timeAgo = [RSTimeAgo timeAgoSinceUnixtime:sinceTime untilUnixtime:untilTime];

    XCTAssertEqual(timeAgo.valueUnit, RSTimeAgoUnitWeeks);
    XCTAssertEqual(timeAgo.value, 3);
}

- (void)testPrevMonthMonths {
    int const sinceTime = 666230400; // 11.02.1991
    int const untilTime = 668649600; // 11.03.1991

    RSTimeAgo *timeAgo = [RSTimeAgo timeAgoSinceUnixtime:sinceTime untilUnixtime:untilTime];

    XCTAssertEqual(timeAgo.valueUnit, RSTimeAgoUnitMonths);
    XCTAssertEqual(timeAgo.value, 1);
}

- (void)testPrevYearWeeks {
    int const sinceTime = 661392000; // 17.12.1990
    int const untilTime = 663465600; // 10.01.1991

    RSTimeAgo *timeAgo = [RSTimeAgo timeAgoSinceUnixtime:sinceTime untilUnixtime:untilTime];

    XCTAssertEqual(timeAgo.valueUnit, RSTimeAgoUnitWeeks);
    XCTAssertEqual(timeAgo.value, 3);
}

- (void)testPrevYearMonths {
    int const sinceTime = 660787200; // 10.12.1990
    int const untilTime = 663465600; // 10.01.1991

    RSTimeAgo *timeAgo = [RSTimeAgo timeAgoSinceUnixtime:sinceTime untilUnixtime:untilTime];

    XCTAssertEqual(timeAgo.valueUnit, RSTimeAgoUnitMonths);
    XCTAssertEqual(timeAgo.value, 1);
}

- (void)testMonths {
    int const sinceTime = 666230400; // 11.02.1991
    int const untilTime = 697680000; // 10.02.1992

    RSTimeAgo *timeAgo = [RSTimeAgo timeAgoSinceUnixtime:sinceTime untilUnixtime:untilTime];

    XCTAssertEqual(timeAgo.valueUnit, RSTimeAgoUnitYears);
    XCTAssertEqual(timeAgo.value, 1);
}

@end
