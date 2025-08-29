//
//  ClosureFunction.hpp
//  OpenAttributeGraphCxx

#ifndef ClosureFunction_hpp
#define ClosureFunction_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <functional>

OAG_ASSUME_NONNULL_BEGIN

namespace OAG {
template <typename ReturnType, typename... Args>
class ClosureFunction final {
public:
    typedef const void  * _Nullable Context;
    typedef const ReturnType (* _Nullable Callable)(Context OAG_SWIFT_CONTEXT, Args...) OAG_SWIFT_CC(swift);

    OAG_INLINE OAG_CONSTEXPR
    ClosureFunction(Callable function, Context context) OAG_NOEXCEPT :
    _function(function),
    _context(context) {
    }
    
    OAG_INLINE OAG_CONSTEXPR
    ClosureFunction(std::nullptr_t) OAG_NOEXCEPT :
    _function(nullptr),
    _context(nullptr) {
    }
    
    OAG_INLINE
    ~ClosureFunction() noexcept {
    }
    
    OAG_INLINE OAG_CONSTEXPR
    ClosureFunction(const ClosureFunction &value) OAG_NOEXCEPT :
    _function(value._function),
    _context(value._context) {
    }
    
    OAG_INLINE OAG_CONSTEXPR
    explicit operator bool() const OAG_NOEXCEPT {
        return _function != nullptr;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    bool operator==(const ClosureFunction &rhs) const OAG_NOEXCEPT {
        return _function == rhs._function && _context == rhs._context;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    bool operator==(std::nullptr_t) const OAG_NOEXCEPT {
        return _function == nullptr;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    bool operator!=(std::nullptr_t) const OAG_NOEXCEPT {
        return _function != nullptr;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const ReturnType operator()(Args... args) const OAG_NOEXCEPT {
        return _function(_context, std::forward<Args>(args)...);
    }
private:
    Callable _function;
    Context _context;
};
}

OAG_ASSUME_NONNULL_END

#endif /* ClosureFunction_hpp */
