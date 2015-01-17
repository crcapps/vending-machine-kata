//
//  ReturnCoinsTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/**
 Return Coins
 
 As a customer
 I want to have my money returned
 So that I can change my mind about buying stuff from the vending machine
 
 When the return coins is selected, the money the customer has placed in the machine is returned and the display shows INSERT COIN.
 */

@interface ReturnCoinsTests : XCTestCase

@end

@implementation ReturnCoinsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItReturnsInsertedMoneyAndDisplayShowsCorrectMessage {
    NSLog(@"** When the return coins is selected, the money the customer has placed in the machine is returned and the display shows INSERT COIN.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

@end
