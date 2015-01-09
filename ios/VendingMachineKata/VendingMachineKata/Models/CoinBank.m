//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"
#import "NSCountedSet+CoinValue.h"
#import "Notifications.h"
#import "CoinSlot.h"
#import "CoinData.h"

@implementation CoinBank

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [NSCountedSet new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
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
 QED: Don't worry about DynP.
 </SPOILER>
 */

- (BOOL)canMakeChangeForAmount:(NSDecimalNumber *)amount {
    BOOL canMakeChange = NO;
    if ([amount compare:[NSDecimalNumber zero]] == NSOrderedSame) {
        canMakeChange = YES;
    }
    if ([amount compare:self.bankedCoins.value] != NSOrderedDescending) {
        
    }
    return canMakeChange;
}

- (void)sufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *amount = [notification.userInfo objectForKey:kUserInfoKeyChange];
    BOOL canMakeChange = [self canMakeChangeForAmount:amount];
    NSString *notificationName = canMakeChange ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)makeChangeForAmount:(NSDecimalNumber *)amount {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
