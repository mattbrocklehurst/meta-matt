BUILD_CXXFLAGS += "-fpermissive -Wno-error=narrowing -Wno-error=address -Wno-error=nonnull -std=gnu++11"
BUILD_CFLAGS += "-fpermissive"

# This injects the missing equality operators into the DumpMemoryAllocator 
# so that GCC 14's libstdc++ is satisfied.
do_configure:prepend() {
    sed -i '/class DumpMemoryAllocator/,/};/ { 0,/public:/ s/public:/public:\n        template<typename _T1> bool operator==(const DumpMemoryAllocator<_T1>\&) const { return true; }\n        template<typename _T1> bool operator!=(const DumpMemoryAllocator<_T1>\&) const { return false; }/ }' \
        ${S}/src/mm/dumpmemory.hpp
}
