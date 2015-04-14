//
//  ViewController.m
//  AutoLayoutExplained
//
//  Created by Lucas Smith on 10/15/14.
//  Copyright (c) 2014 Volan Studio, llc. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectOffset(self.view.bounds, 0.0f, 0.0f)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 140.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height) animated:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableView];
    
    
    #pragma mark Set Constraints
    NSDictionary *views = @{@"theTableView":self.tableView};
    NSDictionary *metrics = @{@"margintop":@16.0, @"marginright":@0.0, @"marginleft":@0.0};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[theTableView]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[theTableView]|"
                                                                      options:NSLayoutAttributeTop | NSLayoutAttributeBottom
                                                                      metrics:metrics
                                                                        views:views]];
    
}


#pragma mark UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell* cell = [[TableViewCell alloc] init];
    cell.name.text = @"Alfred Molina";
    cell.date.text = @"11:45AM";
    cell.body.text = @"Longer Text that could make it obvious that the text will wrap to a new line and that the cell will be taller.";
    
    [cell.body sizeToFit];
    return cell;
}



@end
