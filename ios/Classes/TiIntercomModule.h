/**
 * titanium-intercom
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020-present Hans Knoechel. All rights reserved.
 */

#import "TiModule.h"

@interface TiIntercomModule : TiModule<UIApplicationDelegate>

- (void)configure:(id)params;

- (void)setUserHash:(id)userHash;

- (void)setBottomPadding:(NSNumber *)bottomPadding;

- (void)setVisible:(NSNumber *)visible;

- (void)registerUser:(id)user;

- (void)updateUser:(id)user;

- (void)logout:(id)unused;

- (void)presentMessenger:(id)unused;

- (void)presentHelpCenter:(id)unused;

- (void)presentCarousel:(id)carouselId;

@end
