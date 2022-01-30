import Intercom from 'ti.intercom';

const apiKey = Ti.Platform.osname === 'android' ? 
    'android_sdk-XXXXXX' :
    'ios_sdk-XXXXXX';

Intercom.configure({
    apiKey,
    appId: 'XXXXXX'
});

Intercom.registerUser({
    identifier: 'USER_ID',
    email: 'USER_EMAIL'
});

const win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

// More APIs
// Intercom.presentMessenger('optional_message');
// Intercom.presentHelpCenter();
// Intercom.presentCarousel('carouselId');

win.addEventListener('open', () => {
    Intercom.updateUser({ name: 'John Doe', email: 'john@doe.com', locale: 'de', customAttributes: { /* ... */ } }); // Optional
    Intercom.visible = true;
});

win.addEventListener('close', () => {
    Intercom.logout();
});

win.open();
