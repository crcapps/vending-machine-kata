//
//  CoinBankTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinBank.h"
#import "CoinData.h"
#import "NSDecimalNumber+Currency.h"

@interface CoinBankTests : XCTestCase

@end

@implementation CoinBankTests

CoinBank *coinBank;

- (void)setUp {
    [super setUp];
    coinBank = [CoinBank new];
}

@end
