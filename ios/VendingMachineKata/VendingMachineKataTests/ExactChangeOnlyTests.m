//
//  ExactChangeOnlyTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/**
 Exact Change Only
 
 As a customer
 I want to be told when exact change is required
 So that I can determine if I can buy something with the money I have before inserting it
 
 When the machine is not able to make change with the money in the machine for any of the items that it sells, it will display EXACT CHANGE ONLY instead of INSERT COINS.
 */

@interface ExactChangeOnlyTests : XCTestCase

@end

@implementation ExactChangeOnlyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItDisplaysTheCorrectMessageForAbilityToMakeChangeForAnyItem {
    NSLog(@"** When the machine is not able to make change with the money in the machine for any of the items that it sells, it will display EXACT CHANGE ONLY instead of INSERT COINS.");
    
    XCTFail(@"*** This test is not yet implemented.");
}

@end
