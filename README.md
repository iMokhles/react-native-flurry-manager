
# react-native-im-flurry-manager ( WIP )

## Getting started

`$ npm install react-native-im-flurry-manager --save`

### Mostly automatic installation

`$ react-native link react-native-im-flurry-manager`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-im-flurry-manager` and add `RNImFlurryManager.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNImFlurryManager.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNImFlurryManagerPackage;` to the imports at the top of the file
  - Add `new RNImFlurryManagerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-im-flurry-manager'
  	project(':react-native-im-flurry-manager').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-im-flurry-manager/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-im-flurry-manager')
  	```

## Usage
```javascript
import RNImFlurryManager from 'react-native-im-flurry-manager';

// TODO: What to do with the module?
RNImFlurryManager;
```
  