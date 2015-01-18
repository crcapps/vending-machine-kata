//
//  DisplayTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Display.h"
#import "CoinSlot.h"
#import "CoinData.h"
#import "Notifications.h"

@interface DisplayTests : XCTestCase

@end

@implementation DisplayTests

Display *display;
CoinSlot *coinSlot;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    display = [Display new];
}

- (void)testItDisplaysValidInitialValue {
    XCTAssert([self itDisplaysValidInitialValue], @"*** Display text was not initialized to a valid initial value!  Expected %@ or %@ but got %@", kDisplayTextInsertCoin, kDisplayTextExactChangeOnly, display.text);
}

- (void)testItDisplaysCorrectAmountAfterCoinsInserted {
    NSString *expectedValueString = @"$0.95";
    NSString *expectedQuarterCumulativeValue = @"$0.75";
    NSString *expectedDimeCumulativeValue = @"$0.85";
    NSInteger numberOfQuarters = 3;
    NSInteger numberOfDimes = 1;
    NSInteger numberOfNickels = 2;
    NSInteger numberOfPennies = 4;
    NSString *currentText;
    
    [self dropCoin:kCoinTypeQuarter amount:numberOfQuarters];
    currentText = [NSString stringWithString:display.text];
    XCTAssert([currentText isEqualToString:expectedQuarterCumulativeValue], @"*** Display text was not updated to current credit! Expected %@ but got %@", expectedQuarterCumulativeValue, currentText);
    
    [self dropCoin:kCoinTypeDime amount:numberOfDimes];
    currentText = [NSString stringWithString:display.text];
    XCTAssert([currentText isEqualToString:expectedDimeCumulativeValue], @"*** Display text was not updated to current credit! Expected %@ but got %@", expectedDimeCumulativeValue, currentText);
    
    [self dropCoin:kCoinTypeNickel amount:numberOfNickels];
    currentText = [NSString stringWithString:display.text];
    XCTAssert([currentText isEqualToString:expectedValueString], @"*** Display text was not updated to current credit! Expected %@ but got %@", expectedValueString, currentText);
    
    [self dropCoin:kCoinTypePenny amount:numberOfPennies];
    currentText = [NSString stringWithString:display.text];
    XCTAssert([currentText isEqualToString:expectedValueString], @"*** Display text was updated when coins were rejected! Expected %@ but got %@", expectedValueString, currentText);
    
    [self dropCoin:kCoinTypeSlug amount:1];
    currentText = [NSString stringWithString:display.text];
    XCTAssert([currentText isEqualToString:expectedValueString], @"*** Display text was updated when coins were rejected! Expected %@ but got %@", expectedValueString, currentText);
    
    [self dropCoin:NSIntegerMax amount:255];
    currentText = [NSString stringWithString:display.text];
    XCTAssert([currentText isEqualToString:expectedValueString], @"*** Display text was updated when coins were rejected! Expected %@ but got %@", expectedValueString, currentText);
    
}

#pragma mark - Helper Methods

- (BOOL)itDisplaysValidInitialValue {
    BOOL initialValueIsValid = NO;
    
    if ([display.text isEqualToString:kDisplayTextInsertCoin] || [display.text isEqualToString:kDisplayTextExactChangeOnly]) {
        initialValueIsValid = YES;
    }
    
    return initialValueIsValid;
}

- (void)dropCoin:(CoinType)coin amount:(NSInteger)amount {
    if (amount > 0) {
        NSNumber *diameter = nil;
        NSNumber *mass = nil;
        NSNumber *thickness = nil;
        switch (coin) {
            case kCoinTypeSlug:
                diameter = @24.26;
                mass = @5.000;
                thickness = @1.52;
                break;
            case kCoinTypeQuarter:
                diameter = @24.26;
                mass = @5.670;
                thickness = @1.75;
                break;
            case kCoinTypeDime:
                diameter = @17.91;
                mass = @2.268;
                thickness = @1.35;
                break;
            case kCoinTypeNickel:
                diameter = @21.21;
                mass = @5.000;
                thickness = @1.95;
                break;
            case kCoinTypePenny:
                diameter = @19.05;
                mass = @2.500;
                thickness = @1.52;
                break;
            default:
                break;
        }
        for (NSInteger index = 0; index < amount; index++) {
            [coinSlot dropCoinWithDiameter:diameter mass:mass thickness:thickness];
        }
    }
}

@end
