//
//  FISShoppingCart.m
//  iOShoppingCart
//
//  Created by David Park on 6/8/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISShoppingCart.h"

@implementation FISShoppingCart



-(NSUInteger)calculateTotalPriceInCents{
    
    NSUInteger rollingSum = 0;
    
    for(FISItem *item in self.items) {
        
        rollingSum += item.priceInCents;
    }
    
    return rollingSum;
}

-(void)addItem:(FISItem *)item{
    
    [self.items addObject:item];
    
}

-(void)removeItem:(FISItem *)item{
    
    [self.items removeObjectAtIndex:[self.items indexOfObject:item]];
    
}

-(void)removeAllItemsLikeItem:(FISItem *)item {
    
    
    while([self.items containsObject:item]) {
        [self.items removeObjectAtIndex:[self.items indexOfObject:item]];
    }
    
}

-(void)sortItemsByNameAsc {
    
    NSSortDescriptor *sortByNameAsc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    self.items = [[self.items sortedArrayUsingDescriptors:@[sortByNameAsc]] mutableCopy];
    
}

-(void)sortItemsByNameDesc {
    
    NSSortDescriptor *sortByNameDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    
    self.items = [[self.items sortedArrayUsingDescriptors:@[sortByNameDesc]] mutableCopy];
    
}

-(void)sortItemsByPriceInCentsAsc {
    
    NSSortDescriptor *sortByPriceAsc = [NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:YES];
    
    self.items = [[self.items sortedArrayUsingDescriptors:@[sortByPriceAsc]] mutableCopy];
    
}

-(void)sortItemsByPriceInCentsDesc {
    
    NSSortDescriptor *sortByPriceDesc = [NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:NO];
    
    self.items = [[self.items sortedArrayUsingDescriptors:@[sortByPriceDesc]] mutableCopy];
    
}

-(NSArray *)allItemsWithName:(NSString *)name {
    
    NSMutableArray *arrayOfItemInstances = [[NSMutableArray alloc] init];
    for(FISItem *itemToCheck in self.items) {
        if ([itemToCheck.name isEqualToString:name]) {
            [arrayOfItemInstances addObject:itemToCheck];
        }
    }
    
    return arrayOfItemInstances;
}

-(NSArray *)allItemsWithMinimumPriceInCents:(NSUInteger)price {

    NSPredicate *highPricePredicate = [NSPredicate predicateWithFormat:@"priceInCents >= %lu", price];
    
    NSArray *highPriceArray = [self.items filteredArrayUsingPredicate:highPricePredicate];
    
    return highPriceArray;
    
}

-(NSArray *)allItemsWithMaximumPriceInCents:(NSUInteger)price {
    
    NSPredicate *lowPricePredicate = [NSPredicate predicateWithFormat:@"priceInCents <= %lu", price];
    
    NSArray *lowPriceArray = [self.items filteredArrayUsingPredicate:lowPricePredicate];
    
    return lowPriceArray;

}

@end
