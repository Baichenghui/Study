//
//  TXModalPresentationViewController.h
//  MultiCustomUIComponent
//
//  Created by fang wang on 17/1/13.
//  Copyright © 2017年 wdy. All rights reserved.
//

#import <UIKit/UIKit.h>
 
/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    scale = scale == 0 ? [[UIScreen mainScreen] scale] : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}

/// 用于居中运算
CG_INLINE CGFloat
CGFloatGetCenter(CGFloat parent, CGFloat child) {
    return flat((parent - child) / 2.0);
}

CG_INLINE CGRect
CGRectSetXY(CGRect rect, CGFloat x, CGFloat y) {
    rect.origin.x = flat(x);
    rect.origin.y = flat(y);
    return rect;
}
 

@class TXModalPresentationViewController;

typedef enum : NSUInteger {
    TXModalPresentationAnimationStyleFade,    // 渐现渐隐，默认
    TXModalPresentationAnimationStylePopup,   // 从中心点弹出
    TXModalPresentationAnimationStyleSlide    // 从下往上升起
} TXModalPresentationAnimationStyle;

@protocol TXModalPresentationContentViewProtocol <NSObject>

@optional

/**
 *  当浮层使用modalController提供的默认布局时，则可通过这个方法告诉modalController当前浮层期望的大小
 *  @param  controller  当前的modalController
 *  @param  limitSize   浮层最大的宽高，由当前modalController的大小及`contentViewMargins`、`maximumContentViewWidth`决定
 *  @return 返回浮层在`limitSize`限定内的大小，如果业务自身不需要限制宽度/高度，则为width/height返回CGFLOAT_MAX即可
 */
- (CGSize)preferredContentSizeInModalPresentationVC:(TXModalPresentationViewController *)controller
                                          limitSize:(CGSize)limitSize;

@end


@protocol TXModalPresentationViewControllerDelegate <NSObject>
@optional

/**
 *  是否应该隐藏浮层，会在调用`hideWithAnimated:completion:`时，以及点击背景遮罩时被调用。默认为YES。
 *  @param  controller  当前的modalController
 *  @return 是否允许隐藏，YES表示允许隐藏，NO表示不允许隐藏
 */
- (BOOL)shouldHideModalPresentationViewController:(TXModalPresentationViewController *)controller;

/**
 *  modalController隐藏后的回调函数，不管是直接调用`hideWithAnimated:completion:`，还是通过点击遮罩触发的隐藏，都会调用这个方法。
 *  如果你想区分这两种方式的隐藏回调，请直接使用hideWithAnimated方法的completion参数，以及`didHideByDimmingViewTappedBlock`属性。
 *  @param  controller  当前的modalController
 */
- (void)didHideModalPresentationViewController:(TXModalPresentationViewController *)controller;
- (void)requestHideAllModalPresentationViewController;
@end


/**
 *  一个提供通用的弹出浮层功能的控件，可以将任意`UIView`或`UIViewController`以浮层的形式显示出来并自动布局。
 *
 *  支持 3 种方式显示浮层：
 *
 *  1. **推荐** 新起一个 `UIWindow` 盖在当前界面上，将 `TXModalPresentationViewController` 以 `rootViewController` 的形式显示出来，可通过 `supportedOrientationMask` 支持横竖屏，不支持在浮层不消失的情况下做界面切换（因为 window 会把背后的 controller 盖住，看不到界面切换）
 *  @code
 *  [modalPresentationViewController showWithAnimated:YES completion:nil];
 *  @endcode
 *
 *  2. 使用系统接口来显示，支持界面切换，**注意** 使用这种方法必定只能以动画的形式来显示浮层，无法以无动画的形式来显示，并且 `animated` 参数必须为 `NO`。可通过 `supportedOrientationMask` 支持横竖屏。
 *  @code
 *  [self presentViewController:modalPresentationViewController animated:NO completion:nil];
 *  @endcode
 *
 *  3. 将浮层作为一个 subview 添加到 `superview` 上，从而能够实现在浮层不消失的情况下进行界面切换，但需要 `superview` 自行管理浮层的大小和横竖屏旋转，而且 `TXModalPresentationViewController` 不能用局部变量来保存，会在显示后被释放，需要自行 retain。横竖屏跟随当前界面的设置。
 *  @code
 *  self.modalPresentationViewController.view.frame = CGRectMake(50, 50, 100, 100);
 *  [self.view addSubview:self.modalPresentationViewController.view];
 *  @endcode
 *
 *  默认的布局会将浮层居中显示，浮层的大小可通过接口控制：
 *  1. 如果是用 `contentViewController`，则可通过 `preferredContentSizeInModalPresentationViewController:limitSize:` 来设置
 *  2. 如果使用 `contentView`，或者使用 `contentViewController` 但没实现 `preferredContentSizeInModalPresentationViewController:limitSize:`，则调用`contentView`的`sizeThatFits:`方法获取大小。
 *
 *  通过`layoutBlock`、`showingAnimation`、`hidingAnimation`可设置自定义的布局、打开及隐藏的动画，并允许你适配键盘升起时的场景。
 *
 *  默认提供背景遮罩`dimmingView`，你也可以使用自己的遮罩 view。
 *
 *  默认提供多种显示动画，可通过 `animationStyle` 来设置。
 *
 *  @warning 如果使用者retain了modalPresentationViewController，注意应该在`hideWithAnimated:completion:`里release
 *
 *  @see TXAlertController
 *  @see TXDialogViewController
 *  @see TXMoreOperationController
 */
@interface TXModalPresentationViewController : UIViewController

@property(nonatomic, weak) id <TXModalPresentationViewControllerDelegate> delegate;

/**
 *  要被弹出的浮层
 *  @warning 当设置了`contentView`时，不要再设置`contentViewController`
 */
@property(nonatomic, strong) UIView *contentView;

/**
 *  背景遮罩，默认为一个普通的`UIView`，背景色为`UIColorMask`，可设置为自己的view，注意`dimmingView`的大小将会盖满整个控件。
 *
 *  `TXModalPresentationViewController`会自动给自定义的`dimmingView`添加手势以实现点击遮罩隐藏浮层。
 */
@property(nonatomic, strong) UIView *dimmingView;
/**
 *  要被弹出的浮层，适用于浮层以UIViewController的形式来管理的情况。
 *  @warning 当设置了`contentViewController`时，`contentViewController.view`会被当成`contentView`使用，因此不要再自行设置`contentView`
 *  @warning 注意`contentViewController`是强引用，容易导致循环引用，使用时请注意
 */
@property(nonatomic, strong) UIViewController<TXModalPresentationContentViewProtocol> *contentViewController;
/**
 *  设置`contentView`布局时与外容器的间距，默认为UIEdgeInsetsMake(15, 15, 15, 15);
 *  @warning 当设置了`layoutBlock`属性时，此属性不生效
 */
@property(nonatomic, assign) UIEdgeInsets contentViewMargins UI_APPEARANCE_SELECTOR;

/**
 *  限制`contentView`布局时的最大宽度，默认为iPhone 6竖屏下的屏幕宽度减去`contentViewMargins`在水平方向的值，
    也即浮层在iPhone 6 Plus或iPad上的宽度以iPhone 6上的宽度为准。
 *  @warning 当设置了`layoutBlock`属性时，此属性不生效
 */
@property(nonatomic, assign) CGFloat maximumContentViewWidth UI_APPEARANCE_SELECTOR;

/**
 *  由于点击遮罩导致浮层被隐藏时的回调（区分于`hideWithAnimated:completion:`里的completion，这里是特地用于点击遮罩的情况）
 */
@property(nonatomic, copy) void (^didHideByDimmingViewTappedBlock)(void);
/**
 *  点击遮罩导致浮层将要被隐藏时的回调
 */
@property(nonatomic, copy) void (^willHideByDimmingViewTappedBlock)(void);
/**
 *  控制当前是否以模态的形式存在。如果以模态的形式存在，则点击空白区域不会隐藏浮层。
 *
 *  默认为NO，也即点击空白区域将会自动隐藏浮层。
 */
 @property(nonatomic, assign, getter=isModal) BOOL modal;

/// 点击 DimmingView 关闭整个弹窗
/// 默认为NO
 @property(nonatomic, assign, getter=isDidDimmingViewToHidden) BOOL didDimmingViewToHidden;

/**
 *  标志当前浮层的显示/隐藏状态，默认为NO。
 */
@property(nonatomic, assign, readonly, getter=isVisible) BOOL visible;

@property(nonatomic, assign) CGRect contentViewFrameApplyTransform;

/**
 *  修改当前界面要支持的横竖屏方向，默认为 SupportedOrientationMask。
 */
@property(nonatomic, assign) UIInterfaceOrientationMask supportedOrientationMask;

/**
 *  设置要使用的显示/隐藏动画的类型，默认为`ModalPresentationAnimationStyleFade`。
 *  @warning 当使用了`showingAnimation`和`hidingAnimation`时，该属性无效
 */
@property(nonatomic, assign) TXModalPresentationAnimationStyle animationStyle UI_APPEARANCE_SELECTOR;


/**
 *  管理自定义的浮层布局，将会在浮层显示前、控件的容器大小发生变化时（例如横竖屏、来电状态栏）被调用
 *  @arg  containerBounds         浮层所在的父容器的大小，也即`self.view.bounds`
 *  @arg  keyboardHeight          键盘在当前界面里的高度，若无键盘，则为0
 *  @arg  contentViewDefaultFrame 不使用自定义布局的情况下的默认布局，会受`contentViewMargins`、`maximumContentViewWidth`、`contentView sizeThatFits:`的影响
 *
 *  @see contentViewMargins
 *  @see maximumContentViewWidth
 */
@property(nonatomic, copy) void (^layoutBlock)(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame);

/**
 *  管理自定义的显示动画，需要管理的对象包括`contentView`和`dimmingView`，在`showingAnimation`被调用前，`contentView`已被添加到界面上。若使用了`layoutBlock`，则会先调用`layoutBlock`，再调用`showingAnimation`。在动画结束后，必须调用参数里的`completion` block。
 *  @arg  dimmingView         背景遮罩的View，请自行设置显示遮罩的动画
 *  @arg  containerBounds     浮层所在的父容器的大小，也即`self.view.bounds`
 *  @arg  keyboardHeight      键盘在当前界面里的高度，若无键盘，则为0
 *  @arg  contentViewFrame    动画执行完后`contentView`的最终frame，若使用了`layoutBlock`，则也即`layoutBlock`计算完后的frame
 *  @arg  completion          动画结束后给到modalController的回调，modalController会在这个回调里做一些状态设置，务必调用。
 */
@property(nonatomic, copy) void (^showingAnimation)(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewFrame, void(^completion)(BOOL finished));

/**
 *  管理自定义的隐藏动画，需要管理的对象包括`contentView`和`dimmingView`，在动画结束后，必须调用参数里的`completion` block。
 *  @arg  dimmingView         背景遮罩的View，请自行设置隐藏遮罩的动画
 *  @arg  containerBounds     浮层所在的父容器的大小，也即`self.view.bounds`
 *  @arg  keyboardHeight      键盘在当前界面里的高度，若无键盘，则为0
 *  @arg  completion          动画结束后给到modalController的回调，modalController会在这个回调里做一些清理工作，务必调用
 */
@property(nonatomic, copy) void (^hidingAnimation)(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, void(^completion)(BOOL finished));

/**
 *  将浮层以 UIWindow 的方式显示出来
 *  @param animated    是否以动画的形式显示
 *  @param completion  显示动画结束后的回调
 */
- (void)showWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/**
 *  将浮层隐藏掉
 *  @param animated    是否以动画的形式隐藏
 *  @param completion  隐藏动画结束后的回调
 *  @warning 这里的`completion`只会在你显式调用`hideWithAnimated:completion:`方法来隐藏浮层时会被调用，如果你通过点击`dimmingView`来触发`hideWithAnimated:completion:`，则completion是不会被调用的，那种情况下如果你要在浮层隐藏后做一些事情，请使用`delegate`提供的`didHideModalPresentationViewController:`方法。
 */
- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/**
 *  将浮层以 addSubview 的方式显示出来
 *
 *  @param view         要显示到哪个 view 上
 *  @param animated     是否以动画的形式显示
 *  @param completion   显示动画结束后的回调
 */
- (void)showInView:(UIView *)view animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/**
 *  将某个 view 上显示的浮层隐藏掉
 *  @param view         要隐藏哪个 view 上的浮层
 *  @param animated     是否以动画的形式隐藏
 *  @param completion   隐藏动画结束后的回调
 *  @warning 这里的`completion`只会在你显式调用`hideInView:animated:completion:`方法来隐藏浮层时会被调用，如果你通过点击`dimmingView`来触发`hideInView:animated:completion:`，则completion是不会被调用的，那种情况下如果你要在浮层隐藏后做一些事情，请使用`delegate`提供的`didHideModalPresentationViewController:`方法。
 */
- (void)hideInView:(UIView *)view animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
@end


@interface TXModalPresentationViewController (Manager)

/**
 *  判断当前App里是否有modalViewController正在显示（存在modalViewController但不可见的时候，也视为不存在）
 *  @return 只要存在正在显示的浮层，则返回YES，否则返回NO
 */
+ (BOOL)isAnyModalPresentationViewControllerVisible;

/**
 *  把所有正在显示的并且允许被隐藏的modalViewController都隐藏掉
 *  @return 只要遇到一个正在显示的并且不能被隐藏的浮层，就会返回NO，否则都返回YES，表示成功隐藏掉所有可视浮层
 *  @see    shouldHideModalPresentationViewController:
 */
+ (BOOL)hideAllVisibleModalPresentationViewControllerIfCan;
@end

@interface TXModalPresentationViewController (UIAppearance)

+ (instancetype)appearance;

@end

@interface UIViewController (TXModalPresentationViewController)

/**
 *  获取弹出当前vieController的TXModalPresentationViewController
 */
@property(nonatomic, weak, readonly) TXModalPresentationViewController *modalPresentedViewController;
@end

@interface UIViewController (Helper)
/**
 *  获取当前controller里的最高层可见viewController（可见的意思是还会判断self.view.window是否存在）
 *
 *  @see 如果要获取当前App里的可见viewController，请使用<i>[Helper visibleViewController]</i>
 *
 *  @return 当前controller里的最高层可见viewController
 */
- (UIViewController *)visibleViewControllerIfExist;
@end

@interface TXModalPresentationWindow : UIWindow

@end


/**********************************************************************************************************/
//  使用介绍
/*
// 自定义显示 和 隐藏动画
- (void)handleLayoutBlockAndAnimation {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    contentView.backgroundColor = [UIColor blackColor];
    contentView.layer.cornerRadius = 6;
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"hello world!";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, contentView.frame.size.width, 50);
    label.center = CGPointMake(contentView.center.x, contentView.center.y - 20);
    [contentView addSubview:label];
    
    UITextField* textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(0, 0, contentView.frame.size.width, 30);
    textField.center = CGPointMake(contentView.center.x, contentView.center.y + 40);
    [contentView addSubview:textField];
    
    TXModalPresentationViewController *modalViewController = [[TXModalPresentationViewController alloc] init];
    modalViewController.contentView = contentView;
    //    modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
    //        CGFloat contentViewX = (containerBounds.origin.x - contentView.frame.origin.x)*0.5;
    //        CGFloat contentViewY = (containerBounds.origin.y - contentView.frame.origin.y)*0.5;
    //        contentView.frame = CGRectMake(100,
    //                                       100,
    //                                       (CGRectGetWidth(containerBounds)-CGRectGetWidth(contentView.frame))*0.5,
    //                                       CGRectGetHeight(containerBounds) - 20 - CGRectGetHeight(contentView.frame));
    //    };
    
    modalViewController.showingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewFrame, void(^completion)(BOOL finished)) {
        //        CGFloat contentViewX = (containerBounds.origin.x - contentView.frame.origin.x)*0.5;
        //        CGFloat contentViewY = (containerBounds.origin.y - contentView.frame.origin.y)*0.5;
        //        CGFloat contentViewW = contentView.frame.size.width;
        //        CGFloat contentViewH = contentView.frame.size.height;
        //        contentView.frame = CGRectMake(100, 100, contentViewW, contentViewH);
        dimmingView.alpha = 0;
        [UIView animateWithDuration:.3 delay:0.0 options:TXViewAnimationOptionsCurveOut animations:^{
            dimmingView.alpha = 1;
            contentView.frame = contentViewFrame;
        } completion:^(BOOL finished) {
            // 记住一定要在适当的时机调用completion()
            if (completion) {
                completion(finished);
            }
        }];
    };
    
    modalViewController.hidingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, void(^completion)(BOOL finished)) {
        [UIView animateWithDuration:.3 delay:0.0 options:TXViewAnimationOptionsCurveOut animations:^{
            dimmingView.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 记住一定要在适当的时机调用completion()
            if (completion) {
                completion(finished);
            }
        }];
    };
    [modalViewController showWithAnimated:YES completion:nil];
}


- (void)customDimmingView{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 6;
    
    UIImageView* imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"name01.jpeg"];
    
    TXModalPresentationViewController *modalViewController = [[TXModalPresentationViewController alloc] init];
    modalViewController.dimmingView = imageV;
    modalViewController.contentView = contentView;
    [modalViewController showWithAnimated:YES completion:nil];
}

// 内容是控制器的时候
- (void)testContentViewController{
    
    ModalContentViewController* vc = [[ModalContentViewController alloc] init];
    TXModalPresentationViewController *modalViewController = [[TXModalPresentationViewController alloc] init];
    modalViewController.contentViewController = vc;
    modalViewController.maximumContentViewWidth = CGFLOAT_MAX;
    [modalViewController showWithAnimated:YES completion:nil];
}

// 弹出动画，文本框键盘处理
- (void)testModalViewController{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 6;
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"hello world!";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, contentView.frame.size.width, 50);
    label.center = CGPointMake(contentView.center.x, contentView.center.y - 20);
    [contentView addSubview:label];
    
    UITextField* textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(0, 0, contentView.frame.size.width, 30);
    textField.center = CGPointMake(contentView.center.x, contentView.center.y + 40);
    [contentView addSubview:textField];
    
    // 以Window方式弹出
    TXModalPresentationViewController *modalViewController = [[TXModalPresentationViewController alloc] init];
    modalViewController.contentView = contentView;
    //    modalViewController.maximumContentViewWidth = CGFLOAT_MAX;
    [modalViewController showWithAnimated:YES completion:nil];
    //    [self presentViewController:modalViewController animated:NO completion:nil];
    
    //    if (self.myModalViewController) {
    //        [self.myModalViewController hideInView:self.view animated:YES completion:nil];
    //    }
    //
    //    self.myModalViewController = [[TXModalPresentationViewController alloc] init];
    //    self.myModalViewController.contentView = contentView;
    //    self.myModalViewController.animationStyle = TXModalPresentationAnimationStylePopup;
    //    self.myModalViewController.view.frame = self.view.bounds;
    //    [self.myModalViewController showInView:self.view animated:YES completion:nil];
}

*/




































