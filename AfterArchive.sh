set -e

BUILD_INTERMEDIATES="${OBJROOT}"
BUILD_PRODUCTS="${SYMROOT}/../../../../Products"
DEVICE_BIN="${BUILD_INTERMEDIATES}/UninstalledProducts/iphoneos/${TARGET_NAME}.framework"
SIMULATOR_BIN="${BUILD_PRODUCTS}/Debug-iphonesimulator/${TARGET_NAME}.framework"

# Step 1: Clean and create _Archive folder
ARCHIVE_PATH="${SRCROOT}/_Archive"
rm -rf "${ARCHIVE_PATH}"
mkdir "${ARCHIVE_PATH}"

# Step 2: Force build of iphonesimulator library to the default folder
xcodebuild -project "${SRCROOT}/${PROJECT_NAME}.xcodeproj" -target "${PROJECT_NAME}" -configuration "Debug" -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_PRODUCTS}" build

# Step 3:  Copy Release build to _Archive/Release
if [ "${CONFIGURATION}" = "Release" ]; then
if [ -d "${DEVICE_BIN}" ]; then
DEVICE_PATH="${ARCHIVE_PATH}/Release"
mkdir "${DEVICE_PATH}"
cp -r "${DEVICE_BIN}" "${DEVICE_PATH}"
fi

# Step 4: Copy Previous Simulator build to _Archive/Debug
if [ -d "${SIMULATOR_BIN}" ]; then
SIMULATOR_PATH="${ARCHIVE_PATH}/Debug"
mkdir "${SIMULATOR_PATH}"
cp -r "${SIMULATOR_BIN}" "${SIMULATOR_PATH}"
fi

UNIVERSAL_PATH="${ARCHIVE_PATH}/Universal"
mkdir "${UNIVERSAL_PATH}"

# Step 5: Copy Debug to _Archive/Universal
cp -r "${SIMULATOR_BIN}" "${UNIVERSAL_PATH}"

# Step 6: LIPO both binaries into a Universal framework
lipo -create "${DEVICE_BIN}/${TARGET_NAME}" "${SIMULATOR_BIN}/${TARGET_NAME}" -output  "${UNIVERSAL_PATH}/${TARGET_NAME}.framework/${TARGET_NAME}"

# Step 7: Copy Release *.swiftdoc and *.swiftmodule to the Universal framework
cp -r "${DEVICE_BIN}/Modules/${TARGET_NAME}.swiftmodule" "${UNIVERSAL_PATH}/${TARGET_NAME}.framework/Modules/"

# Step 8: Display system notification and open the framework folder
osascript -e "display notification \"Universal framework has been built.\" with title \"${TARGET_NAME}\""
open "${UNIVERSAL_PATH}"

fi

exit 0;
