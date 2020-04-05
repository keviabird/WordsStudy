//
//  ViewController.h
//  Parrot
//
//  Created by Elena Gracheva on 09.03.15.
//  Copyright (c) 2015 Parrot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIButton *colors;
@property(nonatomic, weak) IBOutlet UIButton *figures;
@property(nonatomic, weak) IBOutlet UIButton *fruits;
@property(nonatomic, weak) IBOutlet UIButton *vegetbles;
@property(nonatomic, weak) IBOutlet UIButton *dresses;
@property(nonatomic, weak) IBOutlet UIButton *dishes;
@property(nonatomic, weak) IBOutlet UIButton *animals;
@property(nonatomic, weak) IBOutlet UIButton *furniture;

-(IBAction)selectGroup:(id)sender;

@end

