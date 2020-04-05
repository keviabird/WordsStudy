//
//  ViewController.m
//  Parrot
//
//  Created by Elena Gracheva on 09.03.15.
//  Copyright (c) 2015 Parrot. All rights reserved.
//

#import "ViewController.h"
#import "CardsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () {
    
    AVAudioPlayer *_audioPlayer;
    CardsViewController *cards;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    cards = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectGroup:(id)sender {
    if (cards != nil) {
        return;
    }
    cards = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CardsViewController"];
    NSString *name;
    if (sender == self.colors) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-colors-01", @"parrot-colors-02", @"parrot-colors-03", @"parrot-colors-04", @"parrot-colors-05", @"parrot-colors-06", @"parrot-colors-07", @"parrot-colors-08", @"parrot-colors-09", @"parrot-colors-10", nil];
        name = @"parrot-colors-name";
    } else if (sender == self.fruits) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-fruits-01", @"parrot-fruits-02", @"parrot-fruits-03", @"parrot-fruits-04", @"parrot-fruits-05", @"parrot-fruits-06", @"parrot-fruits-07", @"parrot-fruits-08", @"parrot-fruits-09", @"parrot-fruits-10", nil];
        name = @"parrot-fruits-name";
    } else if (sender == self.vegetbles) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-vegetables-01", @"parrot-vegetables-02", @"parrot-vegetables-03", @"parrot-vegetables-04", @"parrot-vegetables-05", @"parrot-vegetables-06", @"parrot-vegetables-07", @"parrot-vegetables-08", @"parrot-vegetables-09", @"parrot-vegetables-10", nil];
        name = @"parrot-vegetables-name";
    } else if (sender == self.animals) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-animals-01", @"parrot-animals-02", @"parrot-animals-03", @"parrot-animals-04", @"parrot-animals-05", @"parrot-animals-06", @"parrot-animals-07", @"parrot-animals-08", @"parrot-animals-09", @"parrot-animals-10", nil];
        name = @"parrot-animals-name";
    } else if (sender == self.dresses) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-clothers-01", @"parrot-clothers-02", @"parrot-clothers-03", @"parrot-clothers-04", @"parrot-clothers-05", @"parrot-clothers-06", @"parrot-clothers-07", @"parrot-clothers-08", @"parrot-clothers-09", @"parrot-clothers-10", nil];
        name = @"parrot-clothers-name";
    } else if (sender == self.dishes) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-cooking-01", @"parrot-cooking-02", @"parrot-cooking-03", @"parrot-cooking-04", @"parrot-cooking-05", @"parrot-cooking-06", @"parrot-cooking-07", @"parrot-cooking-08", @"parrot-cooking-09", @"parrot-cooking-10", nil];
        name = @"parrot-cooking-name";
    } else if (sender == self.figures) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-shapes-01", @"parrot-shapes-02", @"parrot-shapes-03", @"parrot-shapes-04", @"parrot-shapes-05", @"parrot-shapes-06", @"parrot-shapes-07", @"parrot-shapes-08", @"parrot-shapes-09", @"parrot-shapes-10", nil];
        name = @"parrot-shapes-name";
    } else if (sender == self.furniture) {
        cards.cards = [NSArray arrayWithObjects:@"parrot-furniture-01", @"parrot-furniture-02", @"parrot-furniture-03", @"parrot-furniture-04", @"parrot-furniture-05", @"parrot-furniture-06", @"parrot-furniture-07", @"parrot-furniture-08", @"parrot-furniture-09", @"parrot-furniture-10", nil];
        name = @"parrot-furniture-name";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    NSError *err;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&err];
    [_audioPlayer play];
//    NSLog(@"audio err %@", err);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _audioPlayer.duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_audioPlayer stop];
        [self.navigationController pushViewController:cards animated:YES];
    });
}

@end
