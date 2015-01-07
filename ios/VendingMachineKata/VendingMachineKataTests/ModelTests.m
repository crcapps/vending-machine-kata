//
//  ModelTests.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "VendingMachine.h"
#import "CoinSlot.h"
#import "Display.h"

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

VendingMachine *vendingMachine;
CoinSlot *coinSlot;
Display *display;

- (void)setUp {
    [super setUp];
    vendingMachine = [VendingMachine new];
    coinSlot = [CoinSlot new];
    display = [Display new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVendingMachineClassExists {
    XCTAssertNotNil(vendingMachine, @"VendingMachine class exists.");
}

- (void)testCoinSlotClassExists {
    XCTAssertNotNil(coinSlot, @"CoinSlot class exists");
}

- (void)testDisplayClassExists {
    XCTAssertNotNil(display, @"Display class exists");
}

- (void)testVendingMachineHasCoinSlot {
    CoinSlot *slot = vendingMachine.coinSlot;
    XCTAssertNotNil(slot);
}

- (void)testVendingMachineHasDisplay {
    Display *screen = vendingMachine.display;
    XCTAssertNotNil(screen);
}

@end
