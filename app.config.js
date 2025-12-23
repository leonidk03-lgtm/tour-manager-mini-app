const isEASBuild = process.env.EAS_BUILD === 'true';

module.exports = {
  expo: {
    name: "TourManager",
    slug: "tour-manager",
    version: "1.0.0",
    orientation: "portrait",
    icon: "./assets/images/icon.png",
    scheme: "tourmanager",
    userInterfaceStyle: "automatic",
    newArchEnabled: isEASBuild,
    ios: {
      supportsTablet: true,
      ...(isEASBuild && { bundleIdentifier: "com.tourmanager.app" }),
      infoPlist: {
        NSAppTransportSecurity: {
          NSAllowsArbitraryLoads: true
        }
      }
    },
    android: {
      ...(isEASBuild && { package: "com.tourmanager.app" }),
      adaptiveIcon: {
        backgroundColor: "#2563EB",
        foregroundImage: "./assets/images/android-icon-foreground.png",
        backgroundImage: "./assets/images/android-icon-background.png",
        monochromeImage: "./assets/images/android-icon-monochrome.png"
      },
      edgeToEdgeEnabled: true,
      predictiveBackGestureEnabled: false,
      usesCleartextTraffic: true
    },
    web: {
      output: "single",
      favicon: "./assets/images/favicon.png"
    },
    plugins: [
      [
        "expo-splash-screen",
        {
          image: "./assets/images/splash-icon.png",
          imageWidth: 200,
          resizeMode: "contain",
          backgroundColor: "#ffffff",
          dark: {
            backgroundColor: "#000000"
          }
        }
      ],
      "expo-web-browser",
      [
        "expo-build-properties",
        {
          android: {
            usesCleartextTraffic: true
          }
        }
      ]
    ],
    experiments: {
      reactCompiler: true
    },
    extra: {
      supabaseUrl: process.env.EXPO_PUBLIC_SUPABASE_URL,
      supabaseAnonKey: process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY,
      ...(isEASBuild && {
        eas: {
          projectId: "e49d79e2-02f4-43f1-a64d-8ae24b0e320d"
        }
      })
    }
  }
};
