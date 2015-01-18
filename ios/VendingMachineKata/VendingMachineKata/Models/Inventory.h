//
//  Inventory.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
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

/** select an item from the machine */
- (NSDecimalNumber *)selectItem:(InventoryItem)item;

/** adds an amount of an item to the inventory and increases the quantity by that amount
 */
- (void)addItem:(InventoryItem)item quantity:(NSInteger)quantity;

@end
