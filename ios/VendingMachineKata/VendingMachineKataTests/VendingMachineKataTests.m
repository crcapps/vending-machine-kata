//
//  VendingMachineKataTests.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>


#import "CoinSlot.h"
#import "Display.h"
#import "CoinData.h"

@interface VendingMachineKataTests : XCTestCase

@end

@implementation VendingMachineKataTests

CoinSlot *coinSlot;
Display *display;
CoinData *coinData;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    display = [Display new];
    coinData = [CoinData new];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Sanity Checks

- (void)testClassesExist {
    XCTAssertNotNil(coinSlot, @"CoinSlot class doesn't exist!");
    XCTAssertNotNil(coinData, @"CoinData class doesn't exist!");
    XCTAssertNotNil(display, @"Display class doesn't exist!");
}

- (void)testInitialDisplayText {
    NSString *expectedText = kDisplayTextInsertCoin;
    NSComparisonResult compare = [expectedText caseInsensitiveCompare:display.text];
    XCTAssertEqual(NSOrderedSame, compare);
}

@end
