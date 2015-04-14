//
//  TableViewCell.m
//  AutoLayoutExplained
//
//  Created by Lucas Smith on 10/15/14.
//  Copyright (c) 2014 Volan Studio, llc. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.meta = [[UIView alloc] initWithFrame:CGRectOffset(self.bounds, 0.0f, 0.0f)];
        self.meta.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.meta];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectOffset(self.bounds, 0.0f, 0.0f)];
        self.name.translatesAutoresizingMaskIntoConstraints = NO;
        self.name.textColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.24f alpha:1.0f];
        UIFontDescriptor *nameFontDesciptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote];
        UIFontDescriptor *nameBodyFontDescriptor = [nameFontDesciptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        self.name.font = [UIFont fontWithDescriptor:nameBodyFontDescriptor size:0.0];
        [self.meta addSubview:self.name];
        
        self.date = [[UILabel alloc] initWithFrame:CGRectOffset(self.bounds, 0.0f, 0.0f)];
        self.date.translatesAutoresizingMaskIntoConstraints = NO;
        self.date.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        self.date.textColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.64f alpha:1.0f];
        self.date.backgroundColor = [UIColor whiteColor];
        self.date.textAlignment = NSTextAlignmentRight;
        [self.meta addSubview:self.date];
        
        
        self.message = [[UIView alloc] initWithFrame:CGRectOffset(self.bounds, 0.0f, 0.0f)];
        self.message.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.message];
        
        self.body = [[UITextView alloc] initWithFrame:CGRectOffset(self.bounds, 0.0f, 0.0f)];
        self.body.translatesAutoresizingMaskIntoConstraints = NO;
        self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        self.body.textColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.24f alpha:1.0f];
        self.body.scrollEnabled = NO;
        self.body.selectable = YES;
        self.body.editable = NO;
        self.body.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypeAddress | UIDataDetectorTypePhoneNumber;
        self.body.textContainerInset = UIEdgeInsetsMake(-2.0f, -5.0f, 0.0f, 0.0f);
        [self.message addSubview:self.body];
        
        
        self.border = [[UIView alloc] initWithFrame:CGRectOffset(self.bounds, 0.0f, 0.0f)];
        self.border.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.87f alpha:1.0f];
        self.border.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.border];
        
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}


#pragma mark Reuse Methods

- (void)displayDate:(NSDate *)createdDate {
    
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
    });
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    components = [cal components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:createdDate];
    NSDate *cellDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:cellDate]) {
        [df setDateFormat:@"h:mma"];
        self.date.text = [df stringFromDate:createdDate];
    } else {
        [df setDateFormat:@"MM/dd h:mma"];
        self.date.text = [df stringFromDate:createdDate];
    }
    
}


- (void)prepareForReuse {
    
    [super prepareForReuse];
    [self setNeedsUpdateConstraints];
    
}



#pragma mark AutoLayout

- (void)updateConstraints {
    
    [super updateConstraints];
    
    NSDictionary *views = @{@"theMeta":self.meta, @"theMessage":self.message, @"theBorder":self.border, @"myBody":self.body, @"myName":self.name, @"myDate":self.date};
    NSDictionary *metrics = @{@"margin":@16.0,
                              @"margintop":[NSNumber numberWithDouble:self.name.font.ascender],
                              @"marginsmall":[NSNumber numberWithDouble:(self.name.font.ascender + fabsf(self.name.font.descender) - 2.0f) / 2.0f],
                              @"marginlarge":[NSNumber numberWithDouble:self.body.font.ascender],
                              @"borderheight":@0.5f};

#pragma mark Layout the SubViews
    
    [self.meta addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[myName]-8-[myDate(<=106)]-margin-|"
                                                                      options:NSLayoutFormatAlignAllBottom
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.meta addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[myName]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.message addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[myBody]-margin-|"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views]];
    
    [self.message addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[myBody]|"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views]];
    
#pragma mark Layout the ContentView
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-margin-[theMeta]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margintop-[theMeta]-marginsmall-[theMessage]-marginlarge-[theBorder(borderheight)]|"
                                                                             options:NSLayoutAttributeTop | NSLayoutAttributeBottom
                                                                             metrics:metrics
                                                                               views:views]];
    
}


#pragma mark Dynamic Type

- (void)didReceiveUIContentSizeCategoryDidChangeNotification:(NSNotification *)notification {
    
    UIFontDescriptor *nameFontDesciptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote];
    UIFontDescriptor *nameBodyFontDescriptor = [nameFontDesciptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    self.name.font = [UIFont fontWithDescriptor:nameBodyFontDescriptor size:0.0];
    self.date.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
}


- (void)viewWillAppear {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveUIContentSizeCategoryDidChangeNotification:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
}

@end