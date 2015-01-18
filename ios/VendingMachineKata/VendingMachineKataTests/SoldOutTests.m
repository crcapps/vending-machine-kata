//
//  SoldOutTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "CoinData.h"
#import "Inventory.h"
#import "Display.h"

/**
 Sold Out
 
 As a customer
 I want to be told when the item I have selected is not available
 So that I can select another item
 
 When the item selected by the customer is out of stock, the machine displays SOLD OUT. If the display is checked again, it will display the amount of money remaining in the machine or INSERT COIN if there is no money in the machine.
 */

@interface SoldOutTests : XCTestCase

@end

@implementation SoldOutTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testItDisplaysTheCorrectMessageWhenTheItemSelectedIsSoldOut {
    NSLog(@"** When the item selected by the customer is out of stock, the machine displays SOLD OUT.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

- (void)testItDisplaysTheCorrectMessageWhenCheckedAgainAfterASoldOutSelection {
    NSLog(@"** If the display is checked again, it will display the amount of money remaining in the machine or INSERT COIN if there is no money in the machine.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

@end
