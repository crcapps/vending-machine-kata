//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"
#import "CoinBag.h"
#import "Notifications.h"
#import "CoinSlot.h"
#import "CoinData.h"
#import "Inventory.h"

@implementation CoinBank

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [CoinBag new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeChange:) name:kNotificationBankCoinsAndMakeChange object:nil];
    }
    
    return self;
}

/*
 ... SOLVING THE VENDING MACHINE CHANGE MAKING PROBLEM!
 (Which lives under the general banner of Counting Principles problems)
 
 Time to get a side of Computer Science with our Software Engineering!
 
 <SPOILER>
 We're going greedy!
 Why, you may ask?  Well, take these theorems/axioms/whatever:
 1) There are very few denominations of coins available.  Three, to be exact.
 2) There is a finite number of available coins in the machine, both inserted and in the bank.
 3) There is a very small set of purchase prices.  Three, to be exact.  What a coincidence!
 4) Two of three of those purchase prices are even multiples of the largest demonination.
 5) Therefore those two can never have a partial coin due as change.
 6) THEREFORE any change due for them is simply the extra change dropped into the slot! WOW!
 7) The difference between the value of the largest denomination and the price of the third
 is the same as the value of the second denomination: handy, that.
 8) The difference in value between the middle and smallest denominations is an aspect of 2:1.
 9) Therefore the change due for the aberrant item is the value for the extra money inserted
 plus either five or ten cents.  Five cents may only be satisfied by a nickel, but ten
 cents can be satisfied by either a dime or two nickels.
 10) If this results in a partial quarter being due (e.g. three quarters inserted), then the
 additional partial coin due is ten cents, and therefore either one dime or two nickels.
 The set of solutions to this case is [D >= 1, N >= 2].
 11) If there is a partial dime due (e.g. two quarters and two dimes inserted), then the
 partial coin due is only satisfied by a nickel.
 The set of solutions here has a cardinality of but one: [N >= 1].
 12) We're going to take all their money before dispensing change!
 13) Therefore, we can ALWAYS make change if the machine contains at least one dime and one nickel,
 or three nickels.  [D >= 1 && N >= 1, N >=3] is the master key to this problem.
 14) Bilbo Baggins
 QED: Don't worry about DynP.  The edge cases that make greedy fail on minimum coins don't exist
      without arbitrary amounts (i.e. pennies).  Pennies make greedy fail on minimum coins.
 
 
 THE REVELATION: This isn't actually the Vending Machine Change Making Problem!
 At least, not in its strictest sense!  Including pennies causes edge cases to arise
 where the greedy approach will fail for minimum coins.  Specifically the edge cases where
 the set of possible inputs are [P < 0 && P > 5].
 
 Far, far more time has been spent on getting the right count out of CoinBag.

 </SPOILER>
 */

- (BOOL)canMakeChangeForAmount:(NSDecimalNumber *)amount onPrice:(NSDecimalNumber *)price withCoinsInserted:(CoinBag *)coins {
    BOOL canMakeChange = NO;
    NSDecimalNumber *bankedValue = self.bankedCoins.value;
    NSDecimalNumber *insertedValue = coins.value;
    NSDecimalNumber *totalAvailable = [bankedValue decimalNumberByAdding:insertedValue];
    if ([amount compare:[NSDecimalNumber zero]] == NSOrderedSame) {
        canMakeChange = YES;
    }
    NSDecimalNumber *dollar = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSDecimalNumber *fiftyCents = [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]];
    NSComparisonResult dollarCompare = [price compare:dollar];
    NSComparisonResult fiftyCentsCompare = [price compare:fiftyCents];
    if (dollarCompare == NSOrderedSame || fiftyCentsCompare == NSOrderedSame) {
        canMakeChange = YES;
    }
    if ([amount compare:totalAvailable] != NSOrderedDescending) {
        // Check the magic threshold for being able to make change for anything.
        NSInteger dimesAvailable = self.bankedCoins.dimes + coins.dimes;
        NSInteger nickelsAvailable = self.bankedCoins.nickels + coins.nickels;
        if (nickelsAvailable >= 3 || ((dimesAvailable >= 1 && nickelsAvailable >= 1))) {
            canMakeChange = YES;
        }
        // Tight coupling?  Violating DRY?
        // Well if we change the price of candy from 65 cents, then everything breaks anyway.
        // If we add something new that isn't the same price as an existing item, everything breaks.
        // Why not just hardcode the value here then?  We'd have to change everything anyway.
        // Plus, finding it again when it needs changed is part of what tests are for!
        NSDecimalNumber *candyPrice = [NSDecimalNumber decimalNumberWithDecimal:[@0.65 decimalValue]];
        NSComparisonResult priceCompare = [price compare:candyPrice];
        if (priceCompare == NSOrderedSame) {
            CoinType leftover = [self findPartialCoinForPrice:price withCoins:coins];
            if (leftover == kCoinTypeNickel && nickelsAvailable >= 1) {
                canMakeChange = YES;
            }
            if (leftover == kCoinTypeDime && (dimesAvailable >= 1 || nickelsAvailable >= 2)) {
                canMakeChange = YES;
            }
        }
    }
    return canMakeChange;
}

/** Greedily divides out the number of quarters comprising a value
 (whether actually present as quarters or not) to find whether we have a dime
 or a nickel remaining.
 */
- (CoinType)findPartialCoinForPrice:(NSDecimalNumber *)price withCoins:(CoinBag *)coins {
    
    NSDecimalNumber *dividend = coins.value;
    
    NSDecimalNumber *divisor = [NSDecimalNumber decimalNumberWithDecimal:[CoinData quarter].coinValue];
    
    NSDecimalNumber *quotient = [dividend decimalNumberByDividingBy:divisor withBehavior:[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
    
    NSDecimalNumber *subtractAmount = [quotient decimalNumberByMultiplyingBy:divisor];
    
    NSDecimalNumber *remainder = [dividend decimalNumberBySubtracting:subtractAmount];
    
    NSDecimalNumber *ten = [NSDecimalNumber decimalNumberWithDecimal:[@10 decimalValue]];
    
    NSComparisonResult partialCompare = [remainder compare:ten];
    
    CoinType partialCoin = kCoinTypeDime;
    
    if (partialCompare == NSOrderedAscending) {
        partialCoin = kCoinTypeNickel;
    }
    
    return partialCoin;
}

- (void)sufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *purchasePrice = [notification.userInfo objectForKey:kUserInfoKeyPrice];
    NSDecimalNumber *changeDue = [notification.userInfo objectForKey:kUserInfoKeyChange];
    CoinBag *insertedCoins = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    BOOL canMakeChange = [self canMakeChangeForAmount:changeDue onPrice:purchasePrice withCoinsInserted:insertedCoins];
    
    
    NSString *notificationName = canMakeChange ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)makeChange:(NSNotification *)notification {
    CoinBag *insertedCoins = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    [insertedCoins emptyInto:self.bankedCoins];
    NSDecimalNumber *changeDue = [notification.userInfo objectForKey:kUserInfoKeyChange];
    BOOL isThereAnyChangeDue = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedSame);
    BOOL isThereMoreChange = isThereAnyChangeDue;
    // Here's where we get greedy, and I mean Tolkien Dwarf King greedy.  Aesopian fable greedy, even.  As much greed as Ozymandias had hubris.  Montgomery C. Burns greedy.
    NSDecimalNumber *quarterValue = [NSDecimalNumber decimalNumberWithDecimal:[CoinData quarter].coinValue];
    NSDecimalNumber *dimeValue = [NSDecimalNumber decimalNumberWithDecimal:[CoinData dime].coinValue];
    NSDecimalNumber *nickelValue = [NSDecimalNumber decimalNumberWithDecimal:[CoinData nickel].coinValue];
    NSComparisonResult quarterCompare = [changeDue compare:quarterValue];
    CoinBag *changeBag = [CoinBag new];
    if (isThereAnyChangeDue) {
        if (quarterCompare != NSOrderedAscending && self.bankedCoins.quarters >= 1) {
            do {
                [changeBag addCoin:[CoinData quarter]];
                changeDue = [changeDue decimalNumberBySubtracting:quarterValue];
                [self.bankedCoins removeCoin:[CoinData quarter]];
                isThereMoreChange = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedDescending);
            } while (self.bankedCoins.quarters >= 1 && isThereMoreChange);
        }
        if (isThereMoreChange) {
            NSComparisonResult dimeCompare = [changeDue compare:dimeValue];
            if (dimeCompare != NSOrderedAscending && self.bankedCoins.dimes >= 1) {
                do {
                    [changeBag addCoin:[CoinData dime]];
                    changeDue = [changeDue decimalNumberBySubtracting:dimeValue];
                    [self.bankedCoins removeCoin:[CoinData dime]];
                    isThereMoreChange = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedDescending);
                } while (self.bankedCoins.dimes >= 1 && isThereMoreChange);
            }
        }
        if (isThereMoreChange) {
            NSComparisonResult nickelCompare = [changeDue compare:nickelValue];
            if (nickelCompare != NSOrderedAscending && self.bankedCoins.nickels >= 1) {
                do {
                    [changeBag addCoin:[CoinData nickel]];
                    changeDue = [changeDue decimalNumberBySubtracting:nickelValue];
                    [self.bankedCoins removeCoin:[CoinData nickel]];
                    isThereMoreChange = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedDescending);
                } while (self.bankedCoins.nickels >= 1 && isThereMoreChange);
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeDispensed object:self userInfo:@{kUserInfoKeyCoins : changeBag}];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
