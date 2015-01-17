//
//  SelectProductTests.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/**
 Select Product
 
 As a vendor
 I want customers to select products
 So that I can give them an incentive to put money in the machine
 
 There are three products: cola for $1.00, chips for $0.50, and candy for $0.65. When the respective button is pressed and enough money has been inserted, the product is dispensed and the machine displays THANK YOU. If the display is checked again, it will display INSERT COINS and the current amount will be set to $0.00. If there is not enough money inserted then the machine displays PRICE and the price of the item and subsequent checks of the display will display either INSERT COINS or the current amount as appropriate.
 */


@interface SelectProductTests : XCTestCase

@end

@implementation SelectProductTests

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSLog(@"\n* Testing User Story: Select Product.\n");
        NSLog(@"As a vendor");
        NSLog(@"I want customers to select products");
        NSLog(@"So that I can give them an incentive to put money in the machine");
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
