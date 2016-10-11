//
//  Spending+CoreDataProperties.m
//  iBudget
//
//  Created by Bulat Saifutdinov on 10/5/16.
//  Copyright © 2016 Bulat Saifutdinov. All rights reserved.
//

#import "Spending+CoreDataProperties.h"

@implementation Spending (CoreDataProperties)

+ (NSFetchRequest<Spending *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Spending"];
}

@dynamic amount;
@dynamic comment;
@dynamic date;
@dynamic title;

@end
