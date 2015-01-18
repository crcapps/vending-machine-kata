//
//  Inventory.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Inventory.h"

@interface Inventory ()

/** Prices of items in inventory, keyed with InventoryItem as NSNumber */
@property (nonatomic, strong, readonly) NSDictionary *itemPrices;

/** Quantities of items in inventory, keyed with InventoryItem as NSNumber */
@property (nonatomic, strong, readonly) NSMapTable *itemQuantities;

@end

@implementation Inventory

@end
