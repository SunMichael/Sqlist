//
//  ViewController.h
//  SQList
//
//  Created by keyrun on 14-4-26.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
NSString *const stringThree =@" asdsdas";
extern const NSString* externString ;
@interface ViewController : UIViewController<UITextFieldDelegate>
{
    sqlite3 *contactDB;
}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)clickSave:(id)sender;
- (IBAction)clickCheck:(id)sender;
- (IBAction)checkall:(id)sender;

UIKIT_EXTERN  NSString *const stringOne;
UIKIT_EXTERN  NSString *const stringTwo;


@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end
