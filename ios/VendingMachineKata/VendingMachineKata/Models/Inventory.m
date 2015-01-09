//
//  Inventory.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Inventory.h"
#import "Notifications.h"

@implementation Inventory

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canMakeChange:) name:kNotificationCanMakeChangeForSelection object:nil];
    }
    
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (NSDictionary *)itemPrices {
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

- (NSMapTable *)itemQuantities {
    static NSMapTable *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = [@{
                  @(kInventoryItemCola) : @0,
                  @(kInventoryItemChips) : @0,
                  @(kInventoryItemCandy) : @0
                  } mutableCopy];
    });
    
    return items;
}

- (NSInteger)quantityForItem:(InventoryItem)item {
    NSInteger quantity = [[self.itemQuantities objectForKey:@(item)] integerValue];
    return quantity;
}

- (void)addItem:(InventoryItem)item quantity:(NSInteger)quantity {
    if (quantity > 0 && [self.itemQuantities objectForKey:@(item)] != nil) {
        NSInteger onHand = [[self.itemQuantities objectForKey:@(item)] integerValue];
        onHand += quantity;
        [self.itemQuantities setObject:@(quantity) forKey:@(item)];
    }
}

- (void)addItem:(InventoryItem)item {
    [self addItem:item quantity:1];
}

- (NSDictionary *)itemNames {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : @"Cola",
                  @(kInventoryItemChips) : @"Chips",
                  @(kInventoryItemCandy) : @"Candy"
                  };
    });
    
    return items;
}

- (NSDecimalNumber *)selectItem:(InventoryItem)item {
    NSDecimalNumber *itemPrice = [self.itemPrices objectForKey:@(item)];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationItemSelected
     object:self
     userInfo:@{
                kUserInfoKeyPrice : itemPrice,
                kUserInfoKeyItem : @(item)
                }];
    
    return itemPrice;
}

- (void)canMakeChange:(NSNotification *)notification {
    InventoryItem item = [[notification.userInfo valueForKey:kUserInfoKeyItem] integerValue];
    NSString *itemString = [self.itemNames objectForKey:@(item)];
    NSInteger itemQuantity = [self quantityForItem:item];
    if (itemQuantity < 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationItemSelectedOutOfStock object:self userInfo:notification.userInfo];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationItemSelectedInStock object:self userInfo:notification.userInfo];
        itemQuantity--;
        [self.itemQuantities setObject:@(itemQuantity) forKey:@(item)];
        NSLog(@"Dispensed a %@.", itemString);
        NSLog(@"There are now %ld left.", (long)itemQuantity);
    }
}

- (void)dispenseProduct:(InventoryItem)item {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
