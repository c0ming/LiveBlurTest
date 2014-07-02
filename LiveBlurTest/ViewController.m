//
//  ViewController.m
//  LiveBlurTest
//
//  Created by c0ming on 14/7/2.
//  Copyright (c) 2014年 c0ming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    UIVisualEffectView *_blurView;
    
    NSArray *_colorsArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colorsArray = @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor yellowColor],
                     [UIColor purpleColor], [UIColor cyanColor], [UIColor orangeColor]];
    
    // UIBlurEffect & UIVisualEffectView
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurView.translatesAutoresizingMaskIntoConstraints = NO;
    _blurView.frame = CGRectMake(60.0, 120.0, 200.0, 120.0);
    _blurView.layer.borderColor = [UIColor whiteColor].CGColor;
    _blurView.layer.borderWidth = 0.5;
    _blurView.layer.cornerRadius = 2.0;
    _blurView.layer.masksToBounds = YES;
    [self.view addSubview:_blurView];

    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_blurView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_blurView(200)]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[_blurView(120)]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_blurView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
}

-(void)viewDidLayoutSubviews {
    // add UILabel to UIVisualEffectView's contentView
    UILabel *label = [[UILabel alloc] initWithFrame:_blurView.bounds];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"UIVisualEffectView";
    [_blurView.contentView addSubview:label];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    cell.backgroundColor = _colorsArray[indexPath.row % _colorsArray.count];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    
    return cell;
}

@end
