@echo off

REM .config/nuget.exe setApiKey -Source GitHub $GITHUB_TOKEN -NonInteractive
REM cmd /C "rmdir /S /Q .vcpkg"

git clone https://github.com/Microsoft/vcpkg.git ./.vcpkg/vcpkg --depth 1
cmd /C ".vcpkg\vcpkg\bootstrap-vcpkg.bat -disableMetrics"


REM SET VCPKG_NUGET_REPOSITORY=https://github.com/aardvark-community/PhysX
.vcpkg\vcpkg\vcpkg.exe install physx --triplet x64-windows-static-md 
REM --binarysource="clear;nuget,Github,readwrite;nugettimeout,1000"

cmake -S src\PhysXNative -B src\PhysXNative\build -DCMAKE_TOOLCHAIN_FILE="%~dp0\.vcpkg\vcpkg\scripts\buildsystems\vcpkg.cmake" -DVCPKG_TARGET_TRIPLET=x64-windows-static-md -DCMAKE_BUILD_TYPE=Release
cmake --build src\PhysXNative\build --config Release --target install
