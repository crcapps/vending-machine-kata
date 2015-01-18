//
//  CoinBagTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinBag.h"
#import "CoinData.h"
#import "NSDecimalNumber+Currency.h"

@interface CoinBagTests : XCTestCase

@end

@implementation CoinBagTests

CoinBag *coinBag;

- (void)setUp {
    [super setUp];
    coinBag = [CoinBag new];
}

- (void)testItReturnsCorrectValueCountAndStringWhenCoinsAreAdded {
    
    NSDecimalNumber *expectedTotalValue = [NSDecimalNumber decimalNumberWithNumber:@0.99];
    NSString *expectedValueString = @"$0.99";
    NSInteger numberOfQuarters = 3;
    NSDecimalNumber *expectedQuartersValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    NSInteger numberOfDimes = 1;
    NSDecimalNumber *expectedDimesValue = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSInteger numberOfNickels = 2;
    NSDecimalNumber *expectedNickelsValue = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSInteger numberOfPennies = 4;
    NSDecimalNumber *expectedPenniesValue = [NSDecimalNumber decimalNumberWithNumber:@0.04];
    NSInteger numberOfCoins = numberOfQuarters + numberOfDimes + numberOfNickels + numberOfPennies;
    
    [coinBag addCoin:[CoinData quarter] amount:numberOfQuarters];
    [coinBag addCoin:[CoinData dime] amount:numberOfDimes];
    [coinBag addCoin:[CoinData nickel] amount:numberOfNickels];
    [coinBag addCoin:[CoinData penny] amount:numberOfPennies];
    
    NSComparisonResult totalCompare = [expectedTotalValue compare:coinBag.value];
    NSComparisonResult quartersCompare = [expectedQuartersValue compare:coinBag.quartersValue];
    NSComparisonResult dimesCompare = [expectedDimesValue compare:coinBag.dimesValue];
    NSComparisonResult nickelsCompare = [expectedNickelsValue compare:coinBag.nickelsValue];
    NSComparisonResult penniesCompare = [expectedPenniesValue compare:coinBag.penniesValue];
    
    XCTAssertEqual(NSOrderedSame, totalCompare, @"*** Total value was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompare);
    XCTAssertEqual(numberOfCoins, coinBag.coins, @"*** Total count was incorrect!  Expected %ld but got %ld", numberOfCoins, coinBag.coins);
    XCTAssert([expectedValueString isEqualToString:coinBag.localizedValueString], @"*** Value string is incorrect! Expected %@ but got %@", expectedValueString, coinBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompare, @"*** Quarters value was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompare);
    XCTAssertEqual(numberOfQuarters, coinBag.quarters, @"*** Quarters count was incorrect!  Expected %ld but got %ld", numberOfQuarters, coinBag.quarters);
    XCTAssertEqual(NSOrderedSame, dimesCompare, @"*** Dimes value was incorrect!  Expected %ld but got %ld", NSOrderedSame, dimesCompare);
    XCTAssertEqual(numberOfDimes, coinBag.dimes, @"*** Dimes count was incorrect!  Expected %ld but got %ld", numberOfDimes, coinBag.dimes);
    XCTAssertEqual(NSOrderedSame, nickelsCompare, @"*** Nickels value was incorrect!  Expected %ld but got %ld", NSOrderedSame, nickelsCompare);
    XCTAssertEqual(numberOfNickels, coinBag.nickels, @"*** Nickels count was incorrect!  Expected %ld but got %ld", numberOfNickels, coinBag.nickels);
    XCTAssertEqual(NSOrderedSame, penniesCompare, @"*** Pennies value was incorrect!  Expected %ld but got %ld", NSOrderedSame, penniesCompare);
    XCTAssertEqual(numberOfPennies, coinBag.pennies, @"*** Pennies count was incorrect!  Expected %ld but got %ld", numberOfPennies, coinBag.pennies);
}

- (void)testItReturnsCorrectValueCountAndStringWhenCoinsAreRemoved {
    [coinBag addCoin:[CoinData quarter] amount:3];
    [coinBag addCoin:[CoinData dime] amount:1];
    [coinBag addCoin:[CoinData nickel] amount:2];
    [coinBag addCoin:[CoinData penny] amount:4];
    
    [coinBag removeCoin:[CoinData quarter] amount:2];
    [coinBag removeCoin:[CoinData dime] amount:1];
    [coinBag removeCoin:[CoinData nickel] amount:1];
    [coinBag removeCoin:[CoinData penny] amount:2];
    
    NSDecimalNumber *expectedTotalValue = [NSDecimalNumber decimalNumberWithNumber:@0.32];
    NSString *expectedValueString = @"$0.32";
    NSInteger numberOfQuarters = 1;
    NSDecimalNumber *expectedQuartersValue = [NSDecimalNumber decimalNumberWithNumber:@0.25];
    NSInteger numberOfDimes = 0;
    NSDecimalNumber *expectedDimesValue = [NSDecimalNumber decimalNumberWithNumber:@0.00];
    NSInteger numberOfNickels = 1;
    NSDecimalNumber *expectedNickelsValue = [NSDecimalNumber decimalNumberWithNumber:@0.05];
    NSInteger numberOfPennies = 2;
    NSDecimalNumber *expectedPenniesValue = [NSDecimalNumber decimalNumberWithNumber:@0.02];
    NSInteger numberOfCoins = numberOfQuarters + numberOfDimes + numberOfNickels + numberOfPennies;
    
    NSComparisonResult totalCompare = [expectedTotalValue compare:coinBag.value];
    NSComparisonResult quartersCompare = [expectedQuartersValue compare:coinBag.quartersValue];
    NSComparisonResult dimesCompare = [expectedDimesValue compare:coinBag.dimesValue];
    NSComparisonResult nickelsCompare = [expectedNickelsValue compare:coinBag.nickelsValue];
    NSComparisonResult penniesCompare = [expectedPenniesValue compare:coinBag.penniesValue];
    
    XCTAssertEqual(NSOrderedSame, totalCompare, @"*** Total value was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompare);
    XCTAssertEqual(numberOfCoins, coinBag.coins, @"*** Total count was incorrect!  Expected %ld but got %ld", numberOfCoins, coinBag.coins);
    XCTAssert([expectedValueString isEqualToString:coinBag.localizedValueString], @"*** Value string is incorrect! Expected %@ but got %@", expectedValueString, coinBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompare, @"*** Quarters value was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompare);
    XCTAssertEqual(numberOfQuarters, coinBag.quarters, @"*** Quarters count was incorrect!  Expected %ld but got %ld", numberOfQuarters, coinBag.quarters);
    XCTAssertEqual(NSOrderedSame, dimesCompare, @"*** Dimes value was incorrect!  Expected %ld but got %ld", NSOrderedSame, dimesCompare);
    XCTAssertEqual(numberOfDimes, coinBag.dimes, @"*** Dimes count was incorrect!  Expected %ld but got %ld", numberOfDimes, coinBag.dimes);
    XCTAssertEqual(NSOrderedSame, nickelsCompare, @"*** Nickels value was incorrect!  Expected %ld but got %ld", NSOrderedSame, nickelsCompare);
    XCTAssertEqual(numberOfNickels, coinBag.nickels, @"*** Nickels count was incorrect!  Expected %ld but got %ld", numberOfNickels, coinBag.nickels);
    XCTAssertEqual(NSOrderedSame, penniesCompare, @"*** Pennies value was incorrect!  Expected %ld but got %ld", NSOrderedSame, penniesCompare);
    XCTAssertEqual(numberOfPennies, coinBag.pennies, @"*** Pennies count was incorrect!  Expected %ld but got %ld", numberOfPennies, coinBag.pennies);
    
}

- (void)testItReturnsNoIfCoinsCannotBeRemovedAndDoesNotChangeAnything {
    [coinBag addCoin:[CoinData quarter] amount:3];
    
    BOOL removed = [coinBag removeCoin:[CoinData quarter] amount:4];
    
    NSDecimalNumber *expectedTotalValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    NSString *expectedValueString = @"$0.75";
    NSInteger numberOfCoins = 3;
    NSInteger numberOfQuarters = 3;
    NSDecimalNumber *expectedQuartersValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    
    NSComparisonResult totalCompare = [expectedTotalValue compare:coinBag.value];
    NSComparisonResult quartersCompare = [expectedQuartersValue compare:coinBag.quartersValue];
    
    XCTAssertFalse(removed, @"*** Removing invalid number of coins didn't return NO!");
    XCTAssertEqual(NSOrderedSame, totalCompare, @"*** Total value was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompare);
    XCTAssertEqual(numberOfCoins, coinBag.coins, @"*** Total count was incorrect!  Expected %ld but got %ld", numberOfCoins, coinBag.coins);
    XCTAssert([expectedValueString isEqualToString:coinBag.localizedValueString], @"*** Value string is incorrect! Expected %@ but got %@", expectedValueString, coinBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompare, @"*** Quarters value was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompare);
    XCTAssertEqual(numberOfQuarters, coinBag.quarters, @"*** Quarters count was incorrect!  Expected %ld but got %ld", numberOfQuarters, coinBag.quarters);

}

- (void)testItReturnsCorrectValueCountAndStringWhenEmptiedOutIntoAnotherBag {
    
    CoinBag *newBag = [CoinBag new];
    
    NSDecimalNumber *expectedTotalValue = [NSDecimalNumber decimalNumberWithNumber:@0.99];
    NSString *expectedValueString = @"$0.99";
    NSInteger numberOfQuarters = 3;
    NSDecimalNumber *expectedQuartersValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    NSInteger numberOfDimes = 1;
    NSDecimalNumber *expectedDimesValue = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSInteger numberOfNickels = 2;
    NSDecimalNumber *expectedNickelsValue = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSInteger numberOfPennies = 4;
    NSDecimalNumber *expectedPenniesValue = [NSDecimalNumber decimalNumberWithNumber:@0.04];
    NSInteger numberOfCoins = numberOfQuarters + numberOfDimes + numberOfNickels + numberOfPennies;
    
    [coinBag addCoin:[CoinData quarter] amount:numberOfQuarters];
    [coinBag addCoin:[CoinData dime] amount:numberOfDimes];
    [coinBag addCoin:[CoinData nickel] amount:numberOfNickels];
    [coinBag addCoin:[CoinData penny] amount:numberOfPennies];
    
    [coinBag emptyInto:newBag];
    
    NSDecimalNumber *decimalZero = [NSDecimalNumber zero];
    NSComparisonResult totalCompareOld = [coinBag.value compare:decimalZero];
    NSComparisonResult quartersCompareOld = [coinBag.quartersValue compare:decimalZero];
    NSComparisonResult dimesCompareOld = [coinBag.dimesValue compare:decimalZero];
    NSComparisonResult nickelsCompareOld = [coinBag.nickelsValue compare:decimalZero];
    NSComparisonResult penniesCompareOld = [coinBag.penniesValue compare:decimalZero];
    
    NSComparisonResult totalCompare = [expectedTotalValue compare:newBag.value];
    NSComparisonResult quartersCompare = [expectedQuartersValue compare:newBag.quartersValue];
    NSComparisonResult dimesCompare = [expectedDimesValue compare:newBag.dimesValue];
    NSComparisonResult nickelsCompare = [expectedNickelsValue compare:newBag.nickelsValue];
    NSComparisonResult penniesCompare = [expectedPenniesValue compare:newBag.penniesValue];
    
    XCTAssertEqual(NSOrderedSame, totalCompareOld, @"*** Total value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompareOld);
    XCTAssertEqual(0, coinBag.coins, @"*** Total count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.coins);
    XCTAssert([coinBag.localizedValueString isEqualToString:@"$0.00"], @"*** Value string for old bag is incorrect! Expected %@ but got %@", @"$0.00", coinBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompareOld, @"*** Quarters value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompareOld);
    XCTAssertEqual(0, coinBag.quarters, @"*** Quarters count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.quarters);
    XCTAssertEqual(NSOrderedSame, dimesCompareOld, @"*** Dimes value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, dimesCompareOld);
    XCTAssertEqual(0, coinBag.dimes, @"*** Dimes count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.dimes);
    XCTAssertEqual(NSOrderedSame, nickelsCompareOld, @"*** Nickels value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, nickelsCompareOld);
    XCTAssertEqual(0, coinBag.nickels, @"*** Nickels count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.nickels);
    XCTAssertEqual(NSOrderedSame, penniesCompareOld, @"*** Pennies value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, penniesCompareOld);
    XCTAssertEqual(0, coinBag.pennies, @"*** Pennies count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.pennies);
    
    XCTAssertEqual(NSOrderedSame, totalCompare, @"*** Total value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompare);
    XCTAssertEqual(numberOfCoins, newBag.coins, @"*** Total count in new bag was incorrect!  Expected %ld but got %ld", numberOfCoins, newBag.coins);
    XCTAssert([expectedValueString isEqualToString:newBag.localizedValueString], @"*** Value string for new bag is incorrect! Expected %@ but got %@", expectedValueString, newBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompare, @"*** Quarters value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompare);
    XCTAssertEqual(numberOfQuarters, newBag.quarters, @"*** Quarters count in new bag was incorrect!  Expected %ld but got %ld", numberOfQuarters, newBag.quarters);
    XCTAssertEqual(NSOrderedSame, dimesCompare, @"*** Dimes value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, dimesCompare);
    XCTAssertEqual(numberOfDimes, newBag.dimes, @"*** Dimes count in new bag was incorrect!  Expected %ld but got %ld", numberOfDimes, newBag.dimes);
    XCTAssertEqual(NSOrderedSame, nickelsCompare, @"*** Nickels value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, nickelsCompare);
    XCTAssertEqual(numberOfNickels, newBag.nickels, @"*** Nickels count in new bag was incorrect!  Expected %ld but got %ld", numberOfNickels, newBag.nickels);
    XCTAssertEqual(NSOrderedSame, penniesCompare, @"*** Pennies value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, penniesCompare);
    XCTAssertEqual(numberOfPennies, newBag.pennies, @"*** Pennies count in new bag was incorrect!  Expected %ld but got %ld", numberOfPennies, newBag.pennies);
    
}

- (void)testItReturnsCorrectValueCountAndStringWhenCoinsTransferredToAnotherBag {
    CoinBag *newBag = [CoinBag new];
    
    NSDecimalNumber *expectedTotalValue = [NSDecimalNumber decimalNumberWithNumber:@0.99];
    NSString *expectedValueString = @"$0.99";
    NSInteger numberOfQuarters = 3;
    NSDecimalNumber *expectedQuartersValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    NSInteger numberOfDimes = 1;
    NSDecimalNumber *expectedDimesValue = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSInteger numberOfNickels = 2;
    NSDecimalNumber *expectedNickelsValue = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSInteger numberOfPennies = 4;
    NSDecimalNumber *expectedPenniesValue = [NSDecimalNumber decimalNumberWithNumber:@0.04];
    NSInteger numberOfCoins = numberOfQuarters + numberOfDimes + numberOfNickels + numberOfPennies;
    
    [coinBag addCoin:[CoinData quarter] amount:numberOfQuarters];
    [coinBag addCoin:[CoinData dime] amount:numberOfDimes];
    [coinBag addCoin:[CoinData nickel] amount:numberOfNickels];
    [coinBag addCoin:[CoinData penny] amount:numberOfPennies];
    
    [coinBag transferCoin:[CoinData quarter] amount:numberOfQuarters toBag:newBag];
    [coinBag transferCoin:[CoinData dime] amount:numberOfDimes toBag:newBag];
    [coinBag transferCoin:[CoinData nickel] amount:numberOfNickels toBag:newBag];
    [coinBag transferCoin:[CoinData penny] amount:numberOfPennies toBag:newBag];
    
    NSDecimalNumber *decimalZero = [NSDecimalNumber zero];
    NSComparisonResult totalCompareOld = [coinBag.value compare:decimalZero];
    NSComparisonResult quartersCompareOld = [coinBag.quartersValue compare:decimalZero];
    NSComparisonResult dimesCompareOld = [coinBag.dimesValue compare:decimalZero];
    NSComparisonResult nickelsCompareOld = [coinBag.nickelsValue compare:decimalZero];
    NSComparisonResult penniesCompareOld = [coinBag.penniesValue compare:decimalZero];
    
    NSComparisonResult totalCompare = [expectedTotalValue compare:newBag.value];
    NSComparisonResult quartersCompare = [expectedQuartersValue compare:newBag.quartersValue];
    NSComparisonResult dimesCompare = [expectedDimesValue compare:newBag.dimesValue];
    NSComparisonResult nickelsCompare = [expectedNickelsValue compare:newBag.nickelsValue];
    NSComparisonResult penniesCompare = [expectedPenniesValue compare:newBag.penniesValue];
    
    XCTAssertEqual(NSOrderedSame, totalCompareOld, @"*** Total value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompareOld);
    XCTAssertEqual(0, coinBag.coins, @"*** Total count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.coins);
    XCTAssert([coinBag.localizedValueString isEqualToString:@"$0.00"], @"*** Value string for old bag is incorrect! Expected %@ but got %@", @"$0.00", coinBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompareOld, @"*** Quarters value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompareOld);
    XCTAssertEqual(0, coinBag.quarters, @"*** Quarters count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.quarters);
    XCTAssertEqual(NSOrderedSame, dimesCompareOld, @"*** Dimes value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, dimesCompareOld);
    XCTAssertEqual(0, coinBag.dimes, @"*** Dimes count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.dimes);
    XCTAssertEqual(NSOrderedSame, nickelsCompareOld, @"*** Nickels value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, nickelsCompareOld);
    XCTAssertEqual(0, coinBag.nickels, @"*** Nickels count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.nickels);
    XCTAssertEqual(NSOrderedSame, penniesCompareOld, @"*** Pennies value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, penniesCompareOld);
    XCTAssertEqual(0, coinBag.pennies, @"*** Pennies count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.pennies);
    
    XCTAssertEqual(NSOrderedSame, totalCompare, @"*** Total value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompare);
    XCTAssertEqual(numberOfCoins, newBag.coins, @"*** Total count in new bag was incorrect!  Expected %ld but got %ld", numberOfCoins, newBag.coins);
    XCTAssert([expectedValueString isEqualToString:newBag.localizedValueString], @"*** Value string for new bag is incorrect! Expected %@ but got %@", expectedValueString, newBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompare, @"*** Quarters value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompare);
    XCTAssertEqual(numberOfQuarters, newBag.quarters, @"*** Quarters count in new bag was incorrect!  Expected %ld but got %ld", numberOfQuarters, newBag.quarters);
    XCTAssertEqual(NSOrderedSame, dimesCompare, @"*** Dimes value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, dimesCompare);
    XCTAssertEqual(numberOfDimes, newBag.dimes, @"*** Dimes count in new bag was incorrect!  Expected %ld but got %ld", numberOfDimes, newBag.dimes);
    XCTAssertEqual(NSOrderedSame, nickelsCompare, @"*** Nickels value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, nickelsCompare);
    XCTAssertEqual(numberOfNickels, newBag.nickels, @"*** Nickels count in new bag was incorrect!  Expected %ld but got %ld", numberOfNickels, newBag.nickels);
    XCTAssertEqual(NSOrderedSame, penniesCompare, @"*** Pennies value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, penniesCompare);
    XCTAssertEqual(numberOfPennies, newBag.pennies, @"*** Pennies count in new bag was incorrect!  Expected %ld but got %ld", numberOfPennies, newBag.pennies);
}

- (void)testItReturnsNoIfCoinsCannotBeTransferred {
    [coinBag addCoin:[CoinData quarter] amount:3];
    
    CoinBag *newBag = [CoinBag new];
    
    BOOL transferred = [coinBag transferCoin:[CoinData quarter] amount:4 toBag:newBag];
    
    NSDecimalNumber *expectedTotalValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    NSString *expectedValueString = @"$0.75";
    NSInteger numberOfCoins = 3;
    NSInteger numberOfQuarters = 3;
    NSDecimalNumber *expectedQuartersValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    
    NSComparisonResult totalCompare = [expectedTotalValue compare:coinBag.value];
    NSComparisonResult quartersCompare = [expectedQuartersValue compare:coinBag.quartersValue];
    
    NSDecimalNumber *decimalZero = [NSDecimalNumber zero];
    NSComparisonResult totalCompareNew = [newBag.value compare:decimalZero];
    NSComparisonResult quartersCompareNew = [newBag.quartersValue compare:decimalZero];
    
    XCTAssertFalse(transferred, @"*** Transferring invalid number of coins didn't return NO!");
    XCTAssertEqual(NSOrderedSame, totalCompare, @"*** Total value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompare);
    XCTAssertEqual(numberOfCoins, coinBag.coins, @"*** Total count in old bag was incorrect!  Expected %ld but got %ld", numberOfCoins, coinBag.coins);
    XCTAssert([expectedValueString isEqualToString:coinBag.localizedValueString], @"*** Value string for old bag is incorrect! Expected %@ but got %@", expectedValueString, coinBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompare, @"*** Quarters value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompare);
    XCTAssertEqual(numberOfQuarters, coinBag.quarters, @"*** Quarters count in old bag was incorrect!  Expected %ld but got %ld", numberOfQuarters, coinBag.quarters);
    
    XCTAssertEqual(NSOrderedSame, totalCompareNew, @"*** Total value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompareNew);
    XCTAssertEqual(0, newBag.coins, @"*** Total count in new bag was incorrect!  Expected %d but got %ld", 0, newBag.coins);
    XCTAssert([newBag.localizedValueString isEqualToString:@"$0.00"], @"*** Value string for new bag is incorrect! Expected %@ but got %@", @"$0.00", newBag.localizedValueString);
    XCTAssertEqual(NSOrderedSame, quartersCompareNew, @"*** Quarters value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, quartersCompareNew);
    XCTAssertEqual(0, newBag.quarters, @"*** Quarters count in new bag was incorrect!  Expected %d but got %ld", 0, newBag.quarters);
}

- (void)testItIgnoresInvalidCoins {
    [coinBag addCoin:[CoinData slug] amount:99];
    [coinBag addCoin:nil amount:99];
    
    CoinBag *newBag = [CoinBag new];
    
    [coinBag removeCoin:[CoinData slug] amount:99];
    [coinBag removeCoin:nil amount:99];
    
    [coinBag transferCoin:[CoinData slug] amount:99 toBag:newBag];
    [coinBag transferCoin:nil amount:99 toBag:newBag];
    
    NSDecimalNumber *decimalZero = [NSDecimalNumber zero];
    NSComparisonResult totalCompareOld = [coinBag.value compare:decimalZero];
    NSComparisonResult totalCompareNew = [newBag.value compare:decimalZero];
    
    XCTAssertEqual(NSOrderedSame, totalCompareOld, @"*** Total value in old bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompareOld);
    XCTAssertEqual(0, coinBag.coins, @"*** Total count in old bag was incorrect!  Expected %d but got %ld", 0, coinBag.coins);
    XCTAssert([coinBag.localizedValueString isEqualToString:@"$0.00"], @"*** Value string for old bag is incorrect! Expected %@ but got %@", @"$0.00", coinBag.localizedValueString);
    
    XCTAssertEqual(NSOrderedSame, totalCompareNew, @"*** Total value in new bag was incorrect!  Expected %ld but got %ld", NSOrderedSame, totalCompareNew);
    XCTAssertEqual(0, newBag.coins, @"*** Total count in new bag was incorrect!  Expected %d but got %ld", 0, newBag.coins);
    XCTAssert([newBag.localizedValueString isEqualToString:@"$0.00"], @"*** Value string for new bag is incorrect! Expected %@ but got %@", @"$0.00", newBag.localizedValueString);
}

@end
