//
//  SpendingDetailViewController.m
//  iBudget
//
//  Created by Bulat Saifutdinov on 10/5/16.
//  Copyright © 2016 Bulat Saifutdinov. All rights reserved.
//

#import "SpendingDetailViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface SpendingDetailViewController ()

@end

@implementation SpendingDetailViewController
@synthesize spending;

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    return context;
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.spending) {
        // Update existing spending
        [self.spending setValue:self.titleTextField.text forKey:@"title"];
        [self.spending setValue:[NSDecimalNumber decimalNumberWithString: (self.amountTextField.text)] forKey:@"amount"];
        [self.spending setValue:self.dateDatePicker.date forKey:@"date"];
        [self.spending setValue:self.commentTextView.text forKey:@"comment"];
    } else {
        // Create new managed object
        NSManagedObject *newSpending = [NSEntityDescription insertNewObjectForEntityForName:@"Spending" inManagedObjectContext:[self managedObjectContext]];
        [newSpending setValue:self.titleTextField.text forKey:@"title"];
        [newSpending setValue:[NSDecimalNumber decimalNumberWithString: (self.amountTextField.text)] forKey:@"amount"];
        [newSpending setValue:self.dateDatePicker.date forKey:@"date"];
        [newSpending setValue:self.commentTextView.text forKey:@"comment"];
    }
    
    NSError *error = nil;
    //Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.spending) {
        [self.titleTextField setText:[self.spending valueForKey:@"title"]];
        [self.amountTextField setText:[NSString stringWithFormat:@"%@",[self.spending valueForKey:@"amount"]]];
        [self.dateDatePicker setDate:[self.spending valueForKey:@"date"]];
        [self.commentTextView setText:[self.spending valueForKey:@"comment"]];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}
@end
