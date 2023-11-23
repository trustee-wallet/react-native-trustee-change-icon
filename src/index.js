import { NativeModules, Platform } from 'react-native'

const LINKING_ERROR = `The package 'react-native-trustee-change-icon' doesn't seem to be linked. Make sure: \n\n` + Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) + '- You rebuilt the app after installing the package\n'

const TrusteeChangeIcon = NativeModules.TrusteeChangeIcon
    ? NativeModules.TrusteeChangeIcon
    : new Proxy(
          {},
          {
              get() {
                  throw new Error(LINKING_ERROR)
              }
          }
      )

const getIcon = async () => {
    return await TrusteeChangeIcon.getIcon()
}

const changeIcon = async (/** @type {string} */ iconName) => {
    return await TrusteeChangeIcon.changeIcon(iconName)
}

const changeIconWithAlert = async (/** @type {string} */ iconName) => {
    if (Platform.OS !== 'ios') return
    return await TrusteeChangeIcon.changeIconWithAlert(iconName)
}

export { getIcon, changeIcon, changeIconWithAlert }
