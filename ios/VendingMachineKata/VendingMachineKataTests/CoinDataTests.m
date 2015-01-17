//
//  CoinDataTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinData.h"

@interface CoinDataTests : XCTestCase

@end

CoinData *coinData;

@implementation CoinDataTests

- (void)setUp {
    [super setUp];
    coinData = [CoinData new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
