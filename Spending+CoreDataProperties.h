//
//  Spending+CoreDataProperties.h
//  iBudget
//
//  Created by Bulat Saifutdinov on 10/5/16.
//  Copyright © 2016 Bulat Saifutdinov. All rights reserved.
//

#import "Spending+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Spending (CoreDataProperties)

+ (NSFetchRequest<Spending *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *amount;
@property (nullable, nonatomic, copy) NSString *comment;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
