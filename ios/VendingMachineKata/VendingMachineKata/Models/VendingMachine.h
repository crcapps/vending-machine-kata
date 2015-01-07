//
//  VendingMachine.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoinSlot;
@class Display;
@class CoinReturn;

@interface VendingMachine : NSObject

/** Represents the coin slot of the vending machine. */
@property (nonatomic, strong, readonly) CoinSlot    *coinSlot;

/** Representes the display of the vending machine. */
@property (nonatomic, strong, readonly) Display     *display;

/** Represents the coin return tray of the vending machine. */
@property (nonatomic, strong, readonly) CoinReturn  *coinReturn;

@end
