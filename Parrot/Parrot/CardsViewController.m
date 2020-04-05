//
//  CardsViewController.m
//  Parrot
//
//  Created by Elena Gracheva on 10.03.15.
//  Copyright (c) 2015 Parrot. All rights reserved.
//

#import "CardsViewController.h"
#import "CheckKnowledgeViewController.h"
#import "Util.h"

#import <AVFoundation/AVFoundation.h>

@implementation CardsViewController {
    int current;
    UIImageView *currentView;
    NSTimer *timer;
    BOOL start;
    AVAudioPlayer *_audioPlayer;
}

@synthesize cards;

-(void)viewDidLoad {
    [super viewDidLoad];
    start = YES;
    current = 0;
    UIImage *initial = [Util imageNamed:[cards objectAtIndex:0]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:initial];
    [self.view insertSubview:imageView atIndex:0];
    currentView = imageView;
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showNext) userInfo:nil repeats:YES];
    [timer fire];
    NSString *path = [[NSBundle mainBundle] pathForResource:[cards objectAtIndex:current] ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
}

-(IBAction)back:(id)sender {
    [timer invalidate];
    [_audioPlayer stop];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)showNext {
    if (start) {
        start = NO;
        return;
    }
    
    [_audioPlayer stop];
    current = current + 1;
    if (current >= [cards count]) {
        [timer invalidate];
        [_audioPlayer stop];
        [self checkKnowledge];
        return;
    }
    UIImage *initial = [Util imageNamed:[cards objectAtIndex:current]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:initial];
    CGRect frame = imageView.frame;
    frame.origin.x = self.view.frame.size.width;
    imageView.frame = frame;
    frame.origin.x = - frame.origin.x;
    [self.view insertSubview:imageView atIndex:0];
    [UIView animateWithDuration:0.5 animations:^{
        imageView.frame = currentView.frame;
        currentView.frame = frame;
    } completion:^(BOOL finished) {
        [currentView removeFromSuperview];
        currentView = nil;
        currentView = imageView;
        NSString *path = [[NSBundle mainBundle] pathForResource:[cards objectAtIndex:current] ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        [_audioPlayer play];
    }];
}

-(void)checkKnowledge {
    CheckKnowledgeViewController *checkKnowledgeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CheckKnowledge"];
    checkKnowledgeViewController.cards = [NSMutableArray arrayWithArray:self.cards];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"check" ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _audioPlayer.duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_audioPlayer stop];
        [self.navigationController pushViewController:checkKnowledgeViewController animated:YES];
    });
}

@end
