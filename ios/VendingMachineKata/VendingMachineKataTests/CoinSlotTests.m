//
//  CoinSlotTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"

@interface CoinSlotTests : XCTestCase

@end

@implementation CoinSlotTests

CoinSlot *coinSlot;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
}

@end
