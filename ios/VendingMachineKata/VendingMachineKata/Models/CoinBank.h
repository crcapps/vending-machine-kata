//
//  CoinBank.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinBank : NSObject

/** Represents the collection of coins inserted into the slot */
@property (nonatomic, strong, readonly) NSCountedSet *bankedCoins;

/** Can the bank make change for this amount? */
- (BOOL)canMakeChangeForAmount:(NSDecimalNumber *)amount;

/** Have the bank dispense the change */
- (void)makeChangeForAmount:(NSDecimalNumber *)amount;

@end
