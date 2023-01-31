cmake_minimum_required(VERSION 3.9)
include("cmake/Aardvark.cmake")

project(PhysXNative)
add_library(PhysXNative SHARED PhysXNative.h PhysXNative.cpp)

set(PHYSX_INCLUDE_DIR "C:\\Users\\aszabo\\repo\\PhysX\\physx\\include")
# find_path(PHYSX_INCLUDE_DIR PxPhysicsAPI.h REQUIRED)
find_library(PhysXPvdSDK_LIBRARY NAMES PhysXPvdSDK_64 PhysXPvdSDK_static_64 PATH_SUFFIXES lib PATHS "C:\\Users\\aszabo\\repo\\PhysX\\physx\\bin\\win.x86_64.vc142.mt\\release" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXExtensions_LIBRARY NAMES PhysXExtensions_64 PhysXExtensions_static_64 PATH_SUFFIXES lib PATHS "C:\\Users\\aszabo\\repo\\PhysX\\physx\\bin\\win.x86_64.vc142.mt\\release" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXFoundation_LIBRARY NAMES PhysXFoundation_64 PhysXFoundation_static_64 PATH_SUFFIXES lib PATHS "C:\\Users\\aszabo\\repo\\PhysX\\physx\\bin\\win.x86_64.vc142.mt\\release" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXCommon_LIBRARY NAMES PhysXCommon_64 PhysXCommon_static_64 PATH_SUFFIXES lib PATHS "C:\\Users\\aszabo\\repo\\PhysX\\physx\\bin\\win.x86_64.vc142.mt\\release" NO_DEFAULT_PATH REQUIRED)
find_library(PhysX_LIBRARY NAMES PhysX_64 PhysX_static_64 PATH_SUFFIXES lib PATHS "C:\\Users\\aszabo\\repo\\PhysX\\physx\\bin\\win.x86_64.vc142.mt\\release" NO_DEFAULT_PATH REQUIRED)

if(WIN32 OR APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE ${PhysXPvdSDK_LIBRARY} ${PhysXExtensions_LIBRARY} ${PhysXFoundation_LIBRARY} ${PhysXCommon_LIBRARY} ${PhysX_LIBRARY})
else()
    target_link_libraries(${PROJECT_NAME} PRIVATE -Wl,--start-group ${PhysXPvdSDK_LIBRARY} ${PhysXExtensions_LIBRARY} ${PhysXFoundation_LIBRARY} ${PhysXCommon_LIBRARY} ${PhysX_LIBRARY} -Wl,--end-group)
endif()

target_include_directories(${PROJECT_NAME} PRIVATE ${PHYSX_INCLUDE_DIR})

set(CMAKE_BUILD_TYPE, "Release")
if(UNIX)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -ffunction-sections -fdata-sections -fvisibility=hidden")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -ffunction-sections -fdata-sections -fvisibility=hidden")
endif()



set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if(APPLE)
    set(CMAKE_SHARED_LINKER_FLAGS "-O3 -flto=thin -dead_strip")
elseif(UNIX)
    set(CMAKE_SHARED_LINKER_FLAGS "-O3 -Wl,--gc-sections -Wl,--strip-all")
endif()


# include_directories(~/vcpkg/packages/ceres_arm64-osx/include)
# target_link_libraries(PhysXNative PRIVATE physx)

SET(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/../../libs/Native/PhysX/") 
install(TARGETS PhysXNative DESTINATION ${OS}/${ARCH})