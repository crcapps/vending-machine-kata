//
//  Inventory.h
//  VendingMachineKata
//
//  Created by the Heatherness on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, InventoryItem) {
    kInventoryItemCola,
    kInventoryItemChips,
    kInventoryItemCandy
};

@interface Inventory : NSObject

- (NSDecimalNumber *)selectItem:(InventoryItem)item;

@end
