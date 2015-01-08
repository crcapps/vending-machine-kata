//
//  Inventory.h
//  VendingMachineKata
//
//  Created by the Heatherness on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The types of items in the machine */
typedef NS_ENUM(NSInteger, InventoryItem) {
    kInventoryItemCola,
    kInventoryItemChips,
    kInventoryItemCandy
};

@interface Inventory : NSObject

@property (nonatomic, strong, readonly) NSDictionary    *items;

/** select an item from the machine */
- (NSDecimalNumber *)selectItem:(InventoryItem)item;

@end
