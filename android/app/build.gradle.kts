plugins {
  id("com.android.application")
  id("com.google.gms.google-services")
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}

android {
  namespace = "com.example.love_on_life"
  compileSdk = 36
  ndkVersion = "29.0.13113456"

  defaultConfig {
    applicationId = "com.example.love_on_life"
    minSdk = flutter.minSdkVersion
    targetSdk = 36
    versionCode = 1
    versionName = "1.0"
  }

  compileOptions {
    // Java 11
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    // Enable core library desugaring
    isCoreLibraryDesugaringEnabled = true
  }

  kotlinOptions {
    jvmTarget = "11"
  }

  buildTypes {
    getByName("release") {
      signingConfig = signingConfigs.getByName("debug")
    }
  }
}

flutter {
  source = "../.."
}

dependencies {
  implementation("androidx.appcompat:appcompat:1.4.0")
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
