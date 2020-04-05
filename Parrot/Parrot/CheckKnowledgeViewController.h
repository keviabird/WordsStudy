//
//  CheckKnowledgeViewController.h
//  Parrot
//
//  Created by Elena Gracheva on 25.07.15.
//  Copyright (c) 2015 Parrot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckKnowledgeViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIButton *first;
@property (weak,nonatomic) IBOutlet UIButton *second;
@property (weak,nonatomic) IBOutlet UIButton *third;
@property (weak,nonatomic) IBOutlet UIButton *fourth;

@property (nonatomic) NSMutableArray *cards;


-(IBAction)select:(id)sender;

@end
