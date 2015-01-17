//
//  MakeChangeTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItReturnsTheCorrectChangeWhenCreditExceedsPriceOfSelection {
    NSLog(@"** When a product is selected that costs less than the amount of money in the machine, then the remaining amount is placed in the coin return.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

@end
