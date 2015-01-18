//
//  CoinBank.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoinBag;

@interface CoinBank : NSObject

/** Represents the collection of coins inserted into the slot */
@property (nonatomic, strong, readonly) CoinBag *bankedCoins;

/** If the bank contains the magic threshold to make change for anything (at least 3 coins totalling at least 15 cents) */
@property (nonatomic, readonly) BOOL canMakeChangeForAnything;

@end
