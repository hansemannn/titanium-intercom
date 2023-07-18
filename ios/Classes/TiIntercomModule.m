/**
 * titanium-intercom
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020-present Hans Knoechel. All rights reserved.
 */

#import "TiIntercomModule.h"

#import <TitaniumKit/TitaniumKit.h>
#import <Intercom/Intercom.h>

@implementation TiIntercomModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"a0354e09-4d47-4de7-8321-90d162393b55";
}

- (NSString *)moduleId
{
  return @"ti.intercom";
}

- (void)_configure
{
  [super _configure];
  [[TiApp app] registerApplicationDelegate:self];
}

- (void)_destroy
{
  [super _destroy];
  [[TiApp app] unregisterApplicationDelegate:self];
}

#pragma Public APIs

- (void)configure:(id)params
{
  ENSURE_SINGLE_ARG(params, NSDictionary);

  NSString *apiKey = params[@"apiKey"];
  NSString *appId = params[@"appId"];

  [Intercom setApiKey:apiKey forAppId:appId];
}

- (void)setUserHash:(id)userHash
{
  ENSURE_TYPE(userHash, NSString);

  if (userHash != nil) {
    [Intercom setUserHash:userHash];
  }
}

- (void)setVisible:(NSNumber *)visible
{
  [Intercom setLauncherVisible:[TiUtils boolValue:visible def:NO]];
}

- (void)setBottomPadding:(NSNumber *)bottomPadding
{
  [Intercom setBottomPadding:[TiUtils intValue:bottomPadding]];
}

- (void)registerUser:(id)user
{
  ENSURE_SINGLE_ARG_OR_NIL(user, NSDictionary);

  if (user == nil) {
    [Intercom loginUnidentifiedUserWithSuccess:^{
      // Add success callback?
    } failure:^(NSError * _Nonnull error) {
      // Add error callback?
    }];
    return;
  }

  NSString *userId = user[@"identifier"];
  NSString *email = user[@"email"];
  
  ICMUserAttributes *userAttributes = [ICMUserAttributes new];
  userAttributes.userId = userId;
  userAttributes.email = email;

  if (email == nil) {
    [Intercom loginUserWithUserAttributes:userAttributes success:^{
      // Add success callback?
    } failure:^(NSError * _Nonnull error) {
      // Add error callback?
    }];
  }
}

- (void)updateUser:(id)user
{
  ENSURE_SINGLE_ARG(user, NSDictionary);

  NSString *email = user[@"email"];
  NSString *name = user[@"name"];
  NSString *locale = user[@"locale"];
  NSDictionary *customAttributes = user[@"customAttributes"];

  ICMUserAttributes *userAttributes = [ICMUserAttributes new];

  if (email != nil) {
    userAttributes.email = email;
  }

  if (name != nil) {
    userAttributes.name = name;
  }
  
  if (locale != nil) {
    userAttributes.languageOverride = locale;
  }

  if (customAttributes != nil) {
    userAttributes.customAttributes = customAttributes;
  }

  [Intercom updateUser:userAttributes success:^{
    // Add success callback?
  } failure:^(NSError * _Nonnull error) {
    // Add error callback?
  }];
}

- (void)logout:(id)unused
{
  [Intercom logout];
}

- (void)presentMessenger:(id)unused
{
  [Intercom presentIntercom];
}

- (void)presentMessageComposer:(id)message
{
  ENSURE_SINGLE_ARG_OR_NIL(message, NSString);

  [Intercom presentMessageComposer:[TiUtils stringValue:message]];
}

- (void)presentHelpCenter:(id)unused
{
  [Intercom presentIntercom:helpCenter];
}

- (void)presentCarousel:(id)carouselId
{
  ENSURE_SINGLE_ARG_OR_NIL(carouselId, NSString);

  IntercomContent *content = [IntercomContent new];
  content.contentId = carouselId;

  [Intercom presentContent:content];
}

// MARK: UIApplicationDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [Intercom setDeviceToken:deviceToken failure:^(NSError * _Nullable error) {
    // Add error callback?
  }];
}

@end
