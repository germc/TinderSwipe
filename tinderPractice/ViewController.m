//
//  ViewController.m
//  tinderPractice
//
//  Created by Reza Fatahi on 9/15/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
    UIView* viewQ1;
    UIView* viewQ2;
    UIPanGestureRecognizer *pgr;
    NSMutableArray* arrayColors;
    UILabel* choiceLabel;
    float swipeTransform;
    int arrayColorIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayColors = [[NSMutableArray alloc] initWithArray:@[[UIColor whiteColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor blueColor], [UIColor lightGrayColor], [UIColor darkGrayColor], [UIColor blackColor]]];
    
    arrayColorIndex = 0;
    
    viewQ1 = [[UIView alloc] initWithFrame:self.view.frame];
    viewQ2 = [[UIView alloc] initWithFrame:self.view.frame];
    viewQ1.userInteractionEnabled = YES;
    viewQ2.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    viewQ1.layer.shouldRasterize = YES;
    [viewQ1 setBackgroundColor:[UIColor greenColor]];
    [viewQ2 setBackgroundColor:[UIColor yellowColor]];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewQ2];
    [viewQ2 addSubview:viewQ1];
    
    choiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 200, 140, 50)];
    [choiceLabel setBackgroundColor:[UIColor whiteColor]];
    [choiceLabel setTextAlignment:NSTextAlignmentCenter];
    [choiceLabel setText:@"MoveIt!"];
    [choiceLabel setFont:[UIFont fontWithName:@"Gill Sans" size:21]];
    [choiceLabel setTextColor:[UIColor blackColor]];
    [viewQ1 addSubview:choiceLabel];
    
    pgr = [[UIPanGestureRecognizer alloc]
           initWithTarget:self action:@selector(handlePan:)];
    pgr.delegate = self;
    [viewQ1 addGestureRecognizer:pgr];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    NSLog(@"!");
    CGPoint translation = [recognizer translationInView:self.view];
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{[recognizer.view setCenter:(CGPointMake(recognizer.view.center.x+translation.x * 1.50,recognizer.view.center.y +translation.y* 1.50))];} completion:nil];
    
    CGPoint leftOutOfBounds = CGPointMake(-160, 160);
    CGPoint rightOutOfBounds = CGPointMake(480, 160);
    
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    if (viewQ1.center.x == self.view.center.x) {
        
    }
    
    if(viewQ1.center.x > self.view.center.x){
        
        if(velocity.x > 0){
            swipeTransform = swipeTransform+.0099;
            [choiceLabel setText:@"UP"];
            [choiceLabel setTextAlignment:NSTextAlignmentCenter];
            [choiceLabel setFont:[UIFont fontWithName:@"Gill Sans" size:21]];
            [choiceLabel setBackgroundColor:[UIColor greenColor]];
            [choiceLabel setTextColor:[UIColor blackColor]];
        }
        else if (velocity.x < 0){
            swipeTransform = swipeTransform-.0099;
        }
        [viewQ1 setTransform:CGAffineTransformMakeRotation(swipeTransform)];
    }
    else if(viewQ1.center.x < self.view.center.x){
        //NSLog(@"gesture went left");
        
        if(velocity.x < 0){
            swipeTransform = swipeTransform-.0099;
            [choiceLabel setText:@"DOWN"];
            [choiceLabel setTextAlignment:NSTextAlignmentCenter];
            [choiceLabel setFont:[UIFont fontWithName:@"Gill Sans" size:21]];
            [choiceLabel setBackgroundColor:[UIColor redColor]];
            [choiceLabel setTextColor:[UIColor whiteColor]];
        }
        else if(velocity.x > 0){
            swipeTransform = swipeTransform+.0099;
            //NSLog(@"gesture went left");
            
        }
        [viewQ1 setTransform:CGAffineTransformMakeRotation(swipeTransform)];
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded){
        if (viewQ1.center.x <50){
            [UIView animateWithDuration:.25 animations:^{viewQ1.center = leftOutOfBounds;
            } completion:^(BOOL isFinished){
                if (isFinished == true) {
                    arrayColorIndex++;
                    if (arrayColorIndex >= arrayColors.count) {
                        NSLog(@"set to zero");
                        arrayColorIndex = 0;
                    }
                    viewQ1.hidden = YES;
                    viewQ1 = viewQ2;
                    viewQ2 = [[UIView alloc] initWithFrame:self.view.frame];
                    UIColor* q2Color = arrayColors[arrayColorIndex];
                    if (viewQ1.backgroundColor == q2Color) {
                        NSLog(@"indexCount = %i", arrayColorIndex);
                        if (arrayColorIndex >= arrayColors.count) {
                            arrayColorIndex = 0;
                        } else {
                            arrayColorIndex++;
                        }
                        q2Color = arrayColors[arrayColorIndex];
                    }
                    [viewQ2 setBackgroundColor:q2Color];
                    [self.view addSubview:viewQ2];
                    [viewQ2 addSubview:viewQ1];
                    viewQ1.userInteractionEnabled = YES;
                    viewQ1.layer.shouldRasterize = YES;
                    [viewQ1 addGestureRecognizer:pgr];
                    [viewQ1 addSubview:choiceLabel];
                    [choiceLabel setBackgroundColor:[UIColor whiteColor]];
                    [choiceLabel setTextAlignment:NSTextAlignmentCenter];
                    [choiceLabel setText:@"MoveIt!"];
                    [choiceLabel setTextColor:[UIColor blackColor]];
                }
            }];
        }
        
        else if (viewQ1.center.x > 270){
            [UIView animateWithDuration:.25 animations:^{viewQ1.center = rightOutOfBounds;             } completion:^(BOOL isFinished){
                if (isFinished == true) {
                    arrayColorIndex++;
                    if (arrayColorIndex >= arrayColors.count) {
                        NSLog(@"set to zero");
                        arrayColorIndex = 0;
                    }
                    viewQ1.hidden = YES;
                    viewQ1 = viewQ2;
                    viewQ2 = [[UIView alloc] initWithFrame:self.view.frame];
                    UIColor* q2Color = arrayColors[arrayColorIndex];
                    if (viewQ1.backgroundColor == q2Color) {
                        NSLog(@"indexCount = %i", arrayColorIndex);
                        if (arrayColorIndex >= arrayColors.count) {
                            arrayColorIndex = 0;
                        } else {
                            arrayColorIndex++;
                        }
                        q2Color = arrayColors[arrayColorIndex];
                    }
                    [viewQ2 setBackgroundColor:q2Color];
                    [self.view addSubview:viewQ2];
                    [viewQ2 addSubview:viewQ1];
                    viewQ1.userInteractionEnabled = YES;
                    viewQ1.layer.shouldRasterize = YES;
                    [viewQ1 addGestureRecognizer:pgr];
                    [viewQ1 addSubview:choiceLabel];
                    [choiceLabel setBackgroundColor:[UIColor whiteColor]];
                    [choiceLabel setTextAlignment:NSTextAlignmentCenter];
                    [choiceLabel setText:@"MoveIt!"];
                    [choiceLabel setTextColor:[UIColor blackColor]];
                }
            }];
        }
        else{
            
            [UIView animateWithDuration:.5 animations:^{viewQ1.center =viewQ1.center;[viewQ1 setTransform:CGAffineTransformMakeRotation(0.0)];swipeTransform = 0;} completion:^(BOOL isFinished){
                if (isFinished == true) {
                    [choiceLabel setBackgroundColor:[UIColor whiteColor]];
                    [choiceLabel setTextAlignment:NSTextAlignmentCenter];
                    [choiceLabel setText:@"MoveIt!"];
                    [choiceLabel setTextColor:[UIColor blackColor]];
                    NSLog(@"fucking do something!");
                    
                }
            }];
        }
    }
}

@end
