/**
 * titanium-intercom
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

#import "TiModule.h"

@interface TiIntercomModule : TiModule<UIApplicationDelegate>

- (void)configure:(id)params;

- (void)setVisible:(NSNumber *)visible;

- (void)registerUser:(id)user;

- (void)logout:(id)unused;

- (void)presentMessenger:(id)unused;

- (void)presentCarousel:(id)carouselId;

@end
