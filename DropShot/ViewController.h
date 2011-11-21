//
//  ViewController.h
//  DropShot
//
//  Created by David Rentsch on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tropfenAnzahlEingabe;
@property (strong, nonatomic) IBOutlet UITextField *tropfenZeitEingabe;
@property (strong, nonatomic) IBOutlet UITextField *tropfenGroesseEingabe;
@property (strong, nonatomic) IBOutlet UITextField *blitzVerzoegerungEingabe;
@property (strong, nonatomic) IBOutlet UILabel *tropfenAnzahlAusgabe;
@property (strong, nonatomic) IBOutlet UILabel *tropfenZeitAusgabe;
@property (strong, nonatomic) IBOutlet UILabel *tropfenGroesseAusgabe;
@property (strong, nonatomic) IBOutlet UILabel *blitzZeitAusgabe;
- (IBAction)buttonPressed:(id)sender;

@end
