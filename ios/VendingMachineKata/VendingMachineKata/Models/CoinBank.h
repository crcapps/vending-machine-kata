//
//  CoinBank.h
//  VendingMachineKata
//
//  Created by the Heatherness on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinBank : NSObject

/** Represents the collection of coins inserted into the slot */
@property (nonatomic, strong, readonly) NSCountedSet *bankedCoins;

@end
