//
//  Inventory.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Inventory.h"
#import "Notifications.h"

@implementation Inventory

- (NSDictionary *)items {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]],
                  @(kInventoryItemChips) : [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]],
                  @(kInventoryItemCandy) : [NSDecimalNumber decimalNumberWithDecimal:[@0.65 decimalValue]]
                  };
    });
    
    return items;
}

- (NSDecimalNumber *)selectItem:(InventoryItem)item {
    return [self.items objectForKey:@(item)];
}

@end
