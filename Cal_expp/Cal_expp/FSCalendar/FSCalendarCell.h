//
//  FSCalendarCell.h
//  Pods
//
//  Created by Wenchao Ding on 12/3/15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FSCalendarMonthPosition);

@class FSCalendar, FSCalendarAppearance;

@interface FSCalendarCell : UICollectionViewCell

#pragma mark - Public properties

/**
 The day text label of the cell
 */
@property (weak, nonatomic) IBOutlet UILabel  *titleLabel;

@property (weak, nonatomic) IBOutlet UIView  *barUnselectedView;
@property (weak, nonatomic) IBOutlet UIView  *barSelectedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint  *barSelectedViewTrailConstraint;


/**
 The shape layer of the cell
 */
@property (weak, nonatomic) CAShapeLayer *shapeLayer;

/**
 A boolean value indicates that whether the cell is "placeholder". Default is NO.
 */
@property (assign, nonatomic, getter=isPlaceholder) BOOL placeholder;

#pragma mark - Private properties

@property (nonatomic) CGFloat progressBar;
@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) FSCalendarAppearance *appearance;

@property (assign, nonatomic) FSCalendarMonthPosition monthPosition;

@property (assign, nonatomic) BOOL dateIsToday;
@property (assign, nonatomic) BOOL weekend;

@property (strong, nonatomic) UIColor *preferredFillDefaultColor;
@property (strong, nonatomic) UIColor *preferredFillSelectionColor;
@property (strong, nonatomic) UIColor *preferredTitleDefaultColor;
@property (strong, nonatomic) UIColor *preferredTitleSelectionColor;
@property (strong, nonatomic) UIColor *preferredBorderDefaultColor;
@property (strong, nonatomic) UIColor *preferredBorderSelectionColor;
@property (assign, nonatomic) CGPoint preferredTitleOffset;

//Added by Dilip
@property (assign, nonatomic) UIColor *preferredBarUnselectedColor;
@property (assign, nonatomic) UIColor *preferredBarSelectedColor;
@property (assign, nonatomic) UIColor *preferredBarNoWorkColor;
//End Dilip

@property (strong, nonatomic) NSArray<UIColor *> *preferredEventDefaultColors;
@property (strong, nonatomic) NSArray<UIColor *> *preferredEventSelectionColors;
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

@interface FSCalendarBlankCell : UICollectionViewCell

- (void)configureAppearance;

@end

