//
//  SpendingDetailViewController.h
//  iBudget
//
//  Created by Bulat Saifutdinov on 10/5/16.
//  Copyright © 2016 Bulat Saifutdinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SpendingDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateDatePicker;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (strong) NSManagedObject *spending;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
