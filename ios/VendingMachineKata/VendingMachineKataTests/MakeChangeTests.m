//
//  MakeChangeTests.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface MakeChangeTests : XCTestCase

@end

/**
 Make Change
 
 As a vendor
 I want customers to receive correct change
 So that they will use the vending machine again
 
 When a product is selected that costs less than the amount of money in the machine, then the remaining amount is placed in the coin return.
 */


@implementation MakeChangeTests

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSLog(@"\n* Testing User Story: Make Change.\n");
        NSLog(@"As a vendor");
        NSLog(@"I want customers to receive correct change");
        NSLog(@"So that they will use the vending machine again");
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
