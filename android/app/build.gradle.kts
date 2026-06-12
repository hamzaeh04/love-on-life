import java.io.FileInputStream
import java.util.Properties

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
  keystorePropertiesFile.inputStream().use { input ->
    keystoreProperties.load(input)
  }
}

plugins {
  id("com.android.application")
  id("com.google.gms.google-services")
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}

android {
  namespace = "com.loveonlife.app"
  compileSdk = 36
  ndkVersion = "29.0.13113456"

  defaultConfig {
    applicationId = "com.loveonlife.app"
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

  signingConfigs {
    create("release") {
      keyAlias = keystoreProperties.getProperty("keyAlias")
      keyPassword = keystoreProperties.getProperty("keyPassword")
      val storeFilePath = keystoreProperties.getProperty("storeFile")
      storeFile = if (storeFilePath != null) rootProject.file(storeFilePath) else null
      storePassword = keystoreProperties.getProperty("storePassword")
    }
  }

  buildTypes {
    getByName("release") {
      signingConfig = signingConfigs.getByName("release")
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
