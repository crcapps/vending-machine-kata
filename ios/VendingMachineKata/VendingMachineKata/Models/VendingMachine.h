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

@interface VendingMachine : NSObject

@property (nonatomic, strong, readonly) CoinSlot    *coinSlot;
@property (nonatomic, strong, readonly) Display     *display;

@end
