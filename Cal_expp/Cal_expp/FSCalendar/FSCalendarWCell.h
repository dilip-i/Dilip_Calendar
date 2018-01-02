//
//  FSCalendarCell.h
//  Pods
//
//  Created by Wenchao Ding on 12/3/15.
//
//

#import <UIKit/UIKit.h>

@class FSCalendar, FSCalendarAppearance;

@interface FSCalendarWCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel  *titleLabel;

@property (weak, nonatomic) IBOutlet UIView  *barView;


/**
 The shape layer of the cell
 */
@property (weak, nonatomic) CAShapeLayer *shapeLayer;

/**
 A boolean value indicates that whether the cell is "placeholder". Default is NO.
 */
@property (assign, nonatomic, getter=isPlaceholder) BOOL placeholder;

#pragma mark - Private properties

@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) FSCalendarAppearance *appearance;

@property (assign, nonatomic) BOOL weekIsToday;

@property (strong, nonatomic) UIColor *preferredFillDefaultColor;
@property (strong, nonatomic) UIColor *preferredFillSelectionColor;
@property (strong, nonatomic) UIColor *preferredTitleDefaultColor;
@property (strong, nonatomic) UIColor *preferredTitleSelectionColor;
@property (strong, nonatomic) UIColor *preferredSubtitleDefaultColor;
@property (strong, nonatomic) UIColor *preferredSubtitleSelectionColor;
@property (strong, nonatomic) UIColor *preferredBorderDefaultColor;
@property (strong, nonatomic) UIColor *preferredBorderSelectionColor;
@property (assign, nonatomic) CGPoint preferredTitleOffset;
@property (assign, nonatomic) CGPoint preferredSubtitleOffset;
@property (assign, nonatomic) CGPoint preferredImageOffset;
@property (assign, nonatomic) CGPoint preferredEventOffset;

@property (assign, nonatomic) CGFloat preferredBorderRadius;

// Add subviews to self.contentView and set up constraints
- (instancetype)initWithFrame:(CGRect)frame NS_REQUIRES_SUPER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_REQUIRES_SUPER;

// For DIY overridden
- (void)layoutSubviews NS_REQUIRES_SUPER; // Configure frames of subviews
- (void)configureAppearance NS_REQUIRES_SUPER; // Configure appearance for cell

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary;
- (void)performSelecting;

@end

