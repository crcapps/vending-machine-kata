//
//  SelectProductTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItDispensesTheCorrectProductAndTheCustomerIsThanked {
    NSLog(@"** There are three products: cola for $1.00, chips for $0.50, and candy for $0.65. When the respective button is pressed and enough money has been inserted, the product is dispensed and the machine displays THANK YOU.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

- (void)testItDisplaysTheCorrectMessageWhenCheckedAgainAfterPurchaseAndTheCreditIsResetToZero {
    NSLog(@"** If the display is checked again, it will display INSERT COINS and the current amount will be set to $0.00.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

- (void)testItDisplaysTheCorrectMessageWhenCheckedWithInsufficientCreditAndDisplasThePriceThenTheCorrectMessage {
    NSLog(@"** If there is not enough money inserted then the machine displays PRICE and the price of the item and subsequent checks of the display will display either INSERT COINS or the current amount as appropriate.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

@end
