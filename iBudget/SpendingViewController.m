//
//  SpendingViewController.m
//  iBudget
//
//  Created by Bulat Saifutdinov on 10/5/16.
//  Copyright © 2016 Bulat Saifutdinov. All rights reserved.
//

#import "SpendingViewController.h"
#import "SpendingDetailViewController.h"
#import "AppDelegate.h"

@interface SpendingViewController ()
@property (strong) NSMutableArray *spengings;

@end

@implementation SpendingViewController


- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    return context;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchResult = [[NSFetchRequest alloc] initWithEntityName:@"Spending"];
    self.spengings = [[managedObjectContext executeFetchRequest:fetchResult error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.spengings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath: indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSManagedObject *spending = [self.spengings objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [spending valueForKey:@"title"]]];
    [cell.detailTextLabel setText:[spending valueForKey:@"title"]];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [managedObjectContext deleteObject:[self.spengings objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.spengings removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"UpdateSpending"]) {
        NSManagedObject *selectedSpending = [self.spengings objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SpendingDetailViewController *spendingDetailViewController = segue.destinationViewController;
        spendingDetailViewController.spending = selectedSpending;
    }
}


@end
