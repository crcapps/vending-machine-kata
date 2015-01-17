//
//  AcceptCoinsTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/15/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/**
Accept Coins
 
 As a vendor
 I want a vending machine that accepts coins
 So that I can collect money from the customer
 
 The vending machine will accept valid coins (nickels, dimes, and quarters) and reject invalid ones (pennies). When a valid coin is inserted the amount of the coin will be added to the current amount and the display will be updated. When there are no coins inserted, the machine displays INSERT COIN. Rejected coins are placed in the coin return.
 */

@interface AcceptCoinsTests : XCTestCase

@end

@implementation AcceptCoinsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItAcceptsValidCoinsAndRejectsInvalidCoins {
    NSLog(@"** The vending machine will accept valid coins (nickels, dimes, and quarters) and reject invalid ones (pennies).");
    
    XCTFail(@"*** This test is not yet implemented.");
}

- (void)testItAddsValueOfInsertedCoinToCurrentAmountAndUpdatesDisplay {
    NSLog(@"** When a valid coin is inserted the amount of the coin will be added to the current amount and the display will be updated.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

- (void)testItDisplaysCorrectMessageWhenNoCoinsAreInserted {
    NSLog(@"** When there are no coins inserted, the machine displays INSERT COIN.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

- (void)testItPlacesRejectedCoinsInTheCoinReturn {
    NSLog(@"** Rejected coins are placed in the coin return.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

@end
