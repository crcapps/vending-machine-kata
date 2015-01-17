//
//  CoinBagTests.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinBag.h"

@interface CoinBagTests : XCTestCase

@end

@implementation CoinBagTests

CoinBag *coinBag;

- (void)setUp {
    [super setUp];
    coinBag = [CoinBag new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
