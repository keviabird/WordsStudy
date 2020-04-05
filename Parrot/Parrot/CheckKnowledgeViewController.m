//
//  CheckKnowledgeViewController.m
//  Parrot
//
//  Created by Elena Gracheva on 25.07.15.
//  Copyright (c) 2015 Parrot. All rights reserved.
//

#import "CheckKnowledgeViewController.h"
#import "Util.h"

#import <AVFoundation/AVFoundation.h>

@interface CheckKnowledgeViewController () {
    int answer;
    AVAudioPlayer *_audioPlayer;
    int tries;
    BOOL answerProcessing;
}

@end

@implementation CheckKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tries = 0;
    while ([self.cards count] > 4) {
        int i = rand() % [self.cards count];
        [self.cards removeObjectAtIndex:i];
    }
    answer = arc4random() % 4;
    
    [self setImage:[Util imageNamed:[self.cards objectAtIndex:0]] forButton:self.first];
    [self setImage:[Util imageNamed:[self.cards objectAtIndex:1]] forButton:self.second];
    [self setImage:[Util imageNamed:[self.cards objectAtIndex:2]] forButton:self.third];
    [self setImage:[Util imageNamed:[self.cards objectAtIndex:3]] forButton:self.fourth];
    answerProcessing = NO;
    [self askQustion];
}

-(void)askQustion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"where" ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _audioPlayer.duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_audioPlayer stop];
        NSString *path = [[NSBundle mainBundle] pathForResource:[self.cards objectAtIndex:answer] ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        [_audioPlayer play];
        answerProcessing = NO;
    });
}

-(void)setImage:(UIImage *)image forButton:(UIButton *)button {
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)select:(UIButton *)sender {
    if (answerProcessing) {
        return;
    }
    answerProcessing = YES;
    [_audioPlayer stop];
    if ((answer == 0 && sender == self.first) || (answer == 1 && sender == self.second) || (answer == 2 && sender == self.third) || (answer == 3 && sender == self.fourth)) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        [_audioPlayer play];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _audioPlayer.duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [_audioPlayer stop];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"welldone" ofType:@"wav"];
            NSURL *soundUrl = [NSURL fileURLWithPath:path];
            _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
            [_audioPlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _audioPlayer.duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [_audioPlayer stop];
                [self showAnswer];
            });
        });
    } else if (tries == 2) {
        tries = 0;
        [self showAnswer];
    } else {
        sender.enabled = NO;
        tries++;
        [self askQustion];
    }
}

-(void)showAnswer {
    NSString *path = [[NSBundle mainBundle] pathForResource:[self.cards objectAtIndex:answer] ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    UIImage *image = [Util imageNamed:[self.cards objectAtIndex:answer]];
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    view.alpha = 0;
    view.frame = self.view.frame;
    [self.view addSubview:view];
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 1;
    } completion:^(BOOL finished) {
        [_audioPlayer play];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _audioPlayer.duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [_audioPlayer stop];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        });
    }];
}

@end
