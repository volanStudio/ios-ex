//
//  TableViewCell.h
//  AutoLayoutExplained
//
//  Created by Lucas Smith on 10/15/14.
//  Copyright (c) 2014 Volan Studio, llc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic) UIView *meta;
@property (nonatomic) UIView *message;
@property (nonatomic) UIView *border;

@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *date;
@property (nonatomic) UITextView *body;

@property (strong) NSMutableArray *customConstraints;

@end
