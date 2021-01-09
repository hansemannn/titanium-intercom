var Intercom = require('ti.intercom');

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

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

win.addEventListener('open', () => {
    Intercom.visible = true;
});

win.open();