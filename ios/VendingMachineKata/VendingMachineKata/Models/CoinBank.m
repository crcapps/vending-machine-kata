//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"
#import "CoinBag.h"
#import "CoinData.h"
#import "NSDecimalNumber+Currency.h"
#import "Notifications.h"

@implementation CoinBank

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
 13) Therefore, we can ALWAYS make change if the machine contains at least three coins with a value of
 at least 15 cents: two dimes and a nickel, one dime and two nickels, or three nickels.
 [D >= 1 && N >= 1, N >=3] is the master key to this problem.
 14) Bilbo Baggins
 QED: Don't worry about DynP.  The edge cases that make greedy fail on minimum coins don't exist
 without arbitrary amounts (i.e. pennies).  Pennies make greedy fail on minimum coins.
 Other weird denominations like 20 euros could do this too, but not with US money.
 
 A really nice side effect of this method is that we are never going to give out quarters as change,
 unless they are just extra quarters the stupid/indecisive customer added themselves.
 
 
 THE REVELATION: This isn't actually the Vending Machine Change Making Problem!
 At least, not in its strictest sense!  Including pennies causes edge cases to arise
 where the greedy approach will fail for minimum coins.  Specifically the edge cases where
 the set of possible inputs are [P > 0 && P < 5].  Yet another reason to drop the penny.
 
 </SPOILER>
 */

static void *bankedCoinsContext = &bankedCoinsContext;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [CoinBag new];
        [self registerForKeyValueObserving];
        [self registerForNotifications];
    }
    
    return self;
}

- (BOOL)canMakeChangeForAnything {
    BOOL threeNickels = self.bankedCoins.nickels >= 3;
    BOOL oneDimeAndTwoNickels = (self.bankedCoins.dimes >= 1 && self.bankedCoins.nickels >= 2);
    BOOL twoDimesAndOneNickel = (self.bankedCoins.dimes >= 2 && self.bankedCoins.nickels >= 1);
    BOOL canMakeChange = NO;
    
    if (threeNickels || oneDimeAndTwoNickels || twoDimesAndOneNickel) {
        canMakeChange = YES;
    }
    
    return canMakeChange;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == bankedCoinsContext) {
        NSString *notificationName = self.canMakeChangeForAnything ? kNotificationCanMakeChangeForAnything : kNotificationCannotMakeChangeForAnything;
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
    }
}

- (void)registerForKeyValueObserving {
    [self.bankedCoins addObserver:self forKeyPath:@"quarters" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:bankedCoinsContext];
    [self.bankedCoins addObserver:self forKeyPath:@"dimes" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:bankedCoinsContext];
    [self.bankedCoins addObserver:self forKeyPath:@"nickels" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:bankedCoinsContext];
    [self.bankedCoins addObserver:self forKeyPath:@"pennies" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:bankedCoinsContext];
}

- (void)unregisterForKeyValueObserving {
    [self.bankedCoins removeObserver:self forKeyPath:@"quarters"];
    [self.bankedCoins removeObserver:self forKeyPath:@"dimes"];
    [self.bankedCoins removeObserver:self forKeyPath:@"nickels"];
    [self.bankedCoins removeObserver:self forKeyPath:@"pennies"];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeChange:) name:kNotificationBankCoinsAndMakeChange object:nil];
}

#pragma mark - Notification Handlers

- (void)sufficientCredit:(NSNotification *)notification {
    NSString *notificationName = self.canMakeChangeForAnything ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)makeChange:(NSNotification *)notification {
    CoinBag *insertedCoins = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    [insertedCoins emptyInto:self.bankedCoins];
    NSDecimalNumber *changeDue = [notification.userInfo objectForKey:kUserInfoKeyChange];
    BOOL isThereAnyChangeDue = NO;
    NSComparisonResult zeroChangeCompare = [changeDue compare:[NSDecimalNumber zero]];
    if (zeroChangeCompare != NSOrderedSame) {
        isThereAnyChangeDue = YES;
    }
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
                [changeBag addCoin:[CoinData quarter] amount:1];
                changeDue = [changeDue decimalNumberBySubtracting:quarterValue];
                [self.bankedCoins removeCoin:[CoinData quarter] amount:1];
                isThereMoreChange = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedDescending);
            } while (self.bankedCoins.quarters >= 1 && isThereMoreChange);
        }
        if (isThereMoreChange) {
            NSComparisonResult dimeCompare = [changeDue compare:dimeValue];
            if (dimeCompare != NSOrderedAscending && self.bankedCoins.dimes >= 1) {
                do {
                    [changeBag addCoin:[CoinData dime] amount:1];
                    changeDue = [changeDue decimalNumberBySubtracting:dimeValue];
                    [self.bankedCoins removeCoin:[CoinData dime] amount:1];
                    isThereMoreChange = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedDescending);
                } while (self.bankedCoins.dimes >= 1 && isThereMoreChange);
            }
        }
        if (isThereMoreChange) {
            NSComparisonResult nickelCompare = [changeDue compare:nickelValue];
            if (nickelCompare != NSOrderedAscending && self.bankedCoins.nickels >= 1) {
                do {
                    [changeBag addCoin:[CoinData nickel] amount:1];
                    changeDue = [changeDue decimalNumberBySubtracting:nickelValue];
                    [self.bankedCoins removeCoin:[CoinData nickel] amount:1];
                    isThereMoreChange = ([changeDue compare:[NSDecimalNumber zero]] == NSOrderedDescending);
                } while (self.bankedCoins.nickels >= 1 && isThereMoreChange);
            }
        }m 
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeDispensed object:self userInfo:@{kUserInfoKeyCoins : changeBag}];
    }

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self unregisterForKeyValueObserving];
}

@end
