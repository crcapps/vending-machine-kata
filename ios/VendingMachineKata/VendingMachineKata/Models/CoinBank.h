//
//  CoinBank.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoinBag;

@interface CoinBank : NSObject

/** Represents the collection of coins inserted into the slot */
@property (nonatomic, strong, readonly) CoinBag *bankedCoins;

/** If the bank contains the magic threshold to make change for anything */
@property (nonatomic, readonly)         BOOL    canMakeChangeForAnything;

/** Can the bank make change for this amount? */
- (BOOL)canMakeChangeForAmount:(NSDecimalNumber *)amount onPrice:(NSDecimalNumber *)price withCoinsInserted:(CoinBag *)coins;

@end
