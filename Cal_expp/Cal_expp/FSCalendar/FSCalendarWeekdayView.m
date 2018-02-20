//
//  FSCalendarWeekdayView.m
//  FSCalendar
//
//  Created by dingwenchao on 03/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "FSCalendarWeekdayView.h"
#import "FSCalendar.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarExtensions.h"

@interface FSCalendarWeekdayView()

@property (strong, nonatomic) NSPointerArray *weekdayPointers;
@property (weak  , nonatomic) UIView *contentView;
@property (weak  , nonatomic) FSCalendar *calendar;
@property (strong  , nonatomic) UIView *gradView;
@property (strong  , nonatomic) CAGradientLayer *gradient;

- (void)commonInit;

@end

@implementation FSCalendarWeekdayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentView];
    _contentView = contentView;
    
    _weekdayPointers = [NSPointerArray weakObjectsPointerArray];
    
    self.gradView = [[UIView alloc] init];
    UILabel *weekNoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    weekNoLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.gradView];
    [self.contentView addSubview:weekNoLabel];
    [_weekdayPointers addPointer:(__bridge void * _Nullable)(weekNoLabel)];
    
    for (int i = 0; i < 7; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:weekdayLabel];
        [_weekdayPointers addPointer:(__bridge void * _Nullable)(weekdayLabel)];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    // Position Calculation
    NSInteger count = self.weekdayPointers.count;
    size_t size = sizeof(CGFloat)*count;
    CGFloat *widths = malloc(size);
    CGFloat contentWidth = self.contentView.fs_width;
    FSCalendarSliceCake(contentWidth, count, widths);
    
    self.gradView.frame = CGRectMake(0, 0, widths[0], self.contentView.fs_height);
    [_gradient removeFromSuperlayer];
    _gradient = [CAGradientLayer layer];
    _gradient.frame = self.gradView.bounds;
    _gradient.colors = self.calendar.wGradientColors?self.calendar.wGradientColors:@[(id)[UIColor colorWithRed:0.0/255.0 green:116.0/255.0 blue:193.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:0.0/255.0 green:108.0/255.0 blue:179.0/255.0 alpha:1.0].CGColor];
    [self.gradView.layer addSublayer:_gradient];
    
    CGFloat x = 0;
    self.gradView.frame = CGRectMake(0, 0, widths[0], self.contentView.fs_height);
    for (NSInteger i = 0; i < count; i++) {
        CGFloat width = widths[i];
        UILabel *label = [self.weekdayPointers pointerAtIndex:i];
        label.frame = CGRectMake(x, 0, width, self.contentView.fs_height);
        x += width;
    }
    free(widths);
}

- (void)setCalendar:(FSCalendar *)calendar
{
    _calendar = calendar;
    [self configureAppearance];
}

- (NSArray<UILabel *> *)weekdayLabels
{
    return self.weekdayPointers.allObjects;
}

- (void)configureAppearance
{
    BOOL useVeryShortWeekdaySymbols = (self.calendar.appearance.caseOptions & (15<<4) ) == FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    NSArray *weekdaySymbols = useVeryShortWeekdaySymbols ? self.calendar.gregorian.veryShortStandaloneWeekdaySymbols : self.calendar.gregorian.shortStandaloneWeekdaySymbols;
    BOOL useDefaultWeekdayCase = self.calendar.appearance.caseOptions  == FSCalendarCaseOptionsWeekdayUsesDefaultCase;
    
    for (NSInteger i = 1; i < self.weekdayPointers.count; i++) {
        NSInteger index = (i-1 + self.calendar.firstWeekday-1) % 7;
        UILabel *label = [self.weekdayPointers pointerAtIndex:i];
        label.font = self.calendar.appearance.weekDayTextFont;
        label.textColor = self.calendar.appearance.weekdayTextColor;
        label.text = useDefaultWeekdayCase ? weekdaySymbols[index] : [weekdaySymbols[index] uppercaseString];
    }
    
    UILabel *label = [self.weekdayPointers pointerAtIndex:0];
    label.font = self.calendar.appearance.wFont;
    label.textColor = self.calendar.appearance.wColor;
    label.text = useDefaultWeekdayCase ? @"w" : @"W";
    label.backgroundColor = [UIColor clearColor];

}

@end
