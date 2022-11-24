window.addEventListener('load', function () {

    if (!('serviceWorker' in navigator)) {
        console.log('Service Worker not supported !');
        return;
    }

    navigator.serviceWorker.register('/progressive/sw.js').then(function (registration) {
        console.log(`Service Worker registration with ${registration.scope} scope successful`);
    }, function (err) {
        console.log(`Service Worker registration failed with error: ${err}`);
    });

});
