//
//  ExactChangeOnlyTests.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/**
 Sold Out
 
 As a customer
 I want to be told when the item I have selected is not available
 So that I can select another item
 
 When the item selected by the customer is out of stock, the machine displays SOLD OUT. If the display is checked again, it will display the amount of money remaining in the machine or INSERT COIN if there is no money in the machine.
 */

@interface ExactChangeOnlyTests : XCTestCase

@end

@implementation ExactChangeOnlyTests

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSLog(@"\n* Testing User Story: Exact Change Only.\n");
        NSLog(@"As a vendor");
        NSLog(@"I want a vending machine that accepts coins");
        NSLog(@"So that I can collect money from the customer");
        NSLog(@"\n");
    }
    
    return self;
}

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
    
    XCTFail(@"This test is not yet implemented.");
}

- (void)testItPlacesRejectedCoinsInTheCoinReturn {
    NSLog(@"Rejected coins are placed in the coin return.");
    
    XCTFail(@"This test is not yet implemented.");
}

@end
