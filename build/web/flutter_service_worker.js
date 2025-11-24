'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "6b9b222d72549ef6b738d6a0cf835e66",
"assets/AssetManifest.bin.json": "ab031bd1d9d16b12f543412d2101377c",
"assets/AssetManifest.json": "81735372753032d355f3208a91cb060d",
"assets/assets/images/aditya.jpeg": "d82c2c1c397a9af47999bab0a382400f",
"assets/assets/images/Disenos/1.png": "e61ea5a0e00db5f927c3c967716e8dd0",
"assets/assets/images/Disenos/2.png": "d9b5a23f57d99600ac71f8d8896e6844",
"assets/assets/images/Disenos/3.png": "5eeccc2fcfd9f34a1b9b707a895c2342",
"assets/assets/images/Disenos/4.png": "9f35a381358361febb2b08344b35e186",
"assets/assets/images/Disenos/5.png": "39ee0d666eb661f34c68492950b33a55",
"assets/assets/images/Disenos/6.png": "d3431b7205334a8f80a35fb65d8ff944",
"assets/assets/images/img.png": "88c5cd462518a29a92178dd643551a50",
"assets/assets/images/MHW/1.png": "46a720737f22c2f345ce4fafa3f26bed",
"assets/assets/images/MHW/2.png": "b528ae58ff4a82a00b50aa822f441745",
"assets/assets/images/MHW/3.png": "6efe9761563f71cf2d4b3951642ab448",
"assets/assets/images/MHW/4.png": "965c974b62d0ac413d510ebf4aab0423",
"assets/assets/images/MHW/5.png": "46ce0ff60e5ed8f601e0613ebbb9df35",
"assets/assets/images/MHW/6.png": "76372ccae6c9feacca753b238eb4192b",
"assets/assets/images/MHWilds/1.png": "d3a69a16daf6ca635bc71f4095a442ba",
"assets/assets/images/MHWilds/2.png": "029257d7bb7d8ac964846de2c83862c6",
"assets/assets/images/MHWilds/3.png": "8fbb19a57fb0f57f3d07acd39517387f",
"assets/assets/images/MHWilds/4.png": "740869e572838b0f1dba0ee5c8fabd80",
"assets/assets/images/MHWilds/5.png": "7e93808306dd5930f0f59c70b4071bf7",
"assets/assets/images/MHWilds/6.png": "aeae36a3dcbbb471ff24f18b943b866c",
"assets/assets/images/MHWilds/7.png": "babbb4dd79e618e41c2566fe136d2f6f",
"assets/assets/images/MHWilds/8.png": "849673e53368a2f4755cc20af6aa824a",
"assets/assets/images/MHWilds/9.png": "a5e47cf399191c16d8a804002268fbe1",
"assets/assets/images/Missions/1.png": "49d96b8eb336c8d117fcdd9509a1bc78",
"assets/assets/images/Missions/10.png": "5c895d4505e2a99e2deabd9b8662f678",
"assets/assets/images/Missions/11.png": "41aa455ad210624e9502d5bdeae30bc0",
"assets/assets/images/Missions/12.png": "0b9e1dd3fe862cdc6165611762bc6c30",
"assets/assets/images/Missions/13.png": "48a018fe19e904e818030cc2a675b3c0",
"assets/assets/images/Missions/14.png": "8330b070dffedaedb841a1e1a517c73b",
"assets/assets/images/Missions/15.png": "da5203129ad3da94bb49775b6d802044",
"assets/assets/images/Missions/2.png": "a3d7dac6918f57855b9f5484ecbffb30",
"assets/assets/images/Missions/3.png": "a703a6e6c5ceb5782580cb2e75ad668b",
"assets/assets/images/Missions/4.png": "7a4dca5b6fbaaae46e62b4a01414caa8",
"assets/assets/images/Missions/5.png": "e4c85d02c32cc9a4fc188a1aeb30680c",
"assets/assets/images/Missions/6.png": "320bcf21b7b0ee15be875f253dd89295",
"assets/assets/images/Missions/7.png": "17055c99fd0eade4230b876d8929849b",
"assets/assets/images/Missions/8.png": "5775686f018f2be4c69c79d083663ed2",
"assets/assets/images/Missions/9.png": "af249e406c97ddc85e46d293b74e393c",
"assets/assets/images/MusicPlayer/1.png": "0dd4d73c42bfe56cb19751f9332dcbcd",
"assets/assets/images/QRScan/1.png": "35dd42885e7f3cadbe0dadd011b760f4",
"assets/assets/images/QRScan/2.png": "cd55ecdb61772043c565eb87355739aa",
"assets/assets/images/QRScan/3.png": "0885356150360edf4c209be976fdbb33",
"assets/assets/images/QRScan/4.png": "21a76097558f1140d7a5d486a04ca98d",
"assets/assets/images/QRScan/5.png": "dcd9e595758621d8febc4689311f60ad",
"assets/assets/images/Shoes/1.png": "33f8fa333078a55520038303da98510f",
"assets/assets/images/Shoes/2.png": "8710a288a4514f06333a99318fa5dc36",
"assets/assets/images/SubastaForestal/1.png": "eb8bb5909fd2048d1c5e34d6d35945e5",
"assets/assets/images/SubastaForestal/2.png": "2b8e8a401cecaa89a4c847f68b15d3db",
"assets/assets/images/SubastaForestal/3.png": "0bfc37ecb8cc9d27dc61a6f4cd84fa26",
"assets/assets/images/SubastaForestal/4.png": "1fda9d16abd2fbb1e10278e86d124626",
"assets/assets/images/Vacar/1.png": "d2cfc4bea14f9085196b9dc622795b93",
"assets/assets/images/Vacar/10.png": "d469d243d93493806a177cb4908332e7",
"assets/assets/images/Vacar/11.png": "faccf719b3f33c95e9494e0670ec6804",
"assets/assets/images/Vacar/2.png": "bdd11bf93a6c5f6e793580ae709a8b2a",
"assets/assets/images/Vacar/3.png": "c25d377c6059d0c30b01f71e1ae2e092",
"assets/assets/images/Vacar/4.png": "fdfc438cb9c2b0db807a75f9c56ec13e",
"assets/assets/images/Vacar/5.png": "1a4cab17c712c9a459679768303d0ab5",
"assets/assets/images/Vacar/6.png": "962b98aecf41faa3f86deff7e6560aa0",
"assets/assets/images/Vacar/7.png": "ca6089fbbd8a5092bf514f43ce44f097",
"assets/assets/images/Vacar/8.png": "ab99b907b75937e618d3318fbc5e3dd1",
"assets/assets/images/Vacar/9.png": "aa4813a532e7c47da376a1a2ffaf9ea0",
"assets/assets/images/Worldshift/1.png": "5d02cec2e5fd9f60e5b5db008b407aed",
"assets/assets/images/Worldshift/2.png": "3a83e510c18d1129c1f51876b646a603",
"assets/assets/images/Worldshift/3.png": "fb0bb68f5d9c0390ad7f5d1032fc4609",
"assets/assets/images/Worldshift/4.png": "bd44bb3212427ea6fbe685510cc22677",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "402dffb6ee9bdd6967a4060b995d647a",
"assets/NOTICES": "4043502fc5ecd5d46649e5cc4a0c76fb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.worker.js": "e35e7fbec8f04f340add4f6ace89a29c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "7939ab92927ead120582c37168a10534",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "dbdaa0638fdbe9203e8d0900c09be828",
"/": "dbdaa0638fdbe9203e8d0900c09be828",
"main.dart.js": "1fbbd63c02da91434a947dc87a1c0a35",
"manifest.json": "30a6ea85f38555c77870a57aeabe8211",
"version.json": "009c9e65172e010890f7f65fde438006"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
