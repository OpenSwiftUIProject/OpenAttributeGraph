//
//  ForwardList.hpp
//  Utilities
//
//  Audited for 6.5.4
//  Status: Complete

#ifndef UTILITIES_FORWARD_LIST_HPP
#define UTILITIES_FORWARD_LIST_HPP

#include <Utilities/Base.hpp>
#include <Utilities/Heap.hpp>

OAG_ASSUME_NONNULL_BEGIN

namespace util {

/// ForwardList is a linked list container that uses util::Heap to allocate nodes,
/// reusing previously removed nodes where possible.
template <typename T> class ForwardList {
  public:
    using reference = T &;
    using const_reference = const T &;

  private:
    struct Node {
        Node *_Nullable next;
        T value;
    };

    util::Heap *_heap;
    Node *_Nullable _front;
    Node *_Nullable _spare;
    bool _is_heap_owner;

  public:
    ForwardList();
    ForwardList(util::Heap *heap);
    ~ForwardList();

    // non-copyable
    ForwardList(const ForwardList &) = delete;
    ForwardList &operator=(const ForwardList &) = delete;

    // non-movable
    ForwardList(ForwardList &&) = delete;
    ForwardList &operator=(ForwardList &&) = delete;

    // MARK: Element access

    reference front();
    const_reference front() const;

    // MARK: Capacity

    bool empty() const noexcept { return _front == nullptr; }

    // MARK: Modifiers

    void push_front(const T &value);
    void push_front(T &&value);
    template <class... Args> void emplace_front(Args &&...args);

    void pop_front();
};

template <typename T>
ForwardList<T>::ForwardList() : _heap(new Heap(nullptr, 0, util::Heap::minimum_increment)), _is_heap_owner(true){};

template <typename T> ForwardList<T>::ForwardList(util::Heap *heap) : _heap(heap), _is_heap_owner(false){};

template <typename T> ForwardList<T>::~ForwardList() {
    if (_is_heap_owner && _heap) {
        delete _heap;
    }
};

template <typename T> ForwardList<T>::reference ForwardList<T>::front() {
    assert(!empty());
    return _front->value;
}

template <typename T> ForwardList<T>::const_reference ForwardList<T>::front() const {
    assert(!empty());
    return _front->value;
}

template <typename T> void ForwardList<T>::push_front(const T &value) {
    Node *new_node;
    if (_spare != nullptr) {
        new_node = _spare;
        _spare = _spare->next;
    } else {
        new_node = _heap->alloc<Node>();
    }
    new_node->next = _front;
    new_node->value = value;
    _front = new_node;
}

template <typename T> void ForwardList<T>::push_front(T &&value) {
    Node *new_node;
    if (_spare != nullptr) {
        new_node = _spare;
        _spare = _spare->previous;
    } else {
        new_node = _heap->alloc<Node>();
    }
    new_node->next = _front;
    new_node->value = std::move(value);
    _front = new_node;
}

template <typename T> template <class... Args> void ForwardList<T>::emplace_front(Args &&...args) {
    Node *new_node;
    if (_spare != nullptr) {
        new_node = _spare;
        _spare = _spare->next;
    } else {
        new_node = _heap->alloc<Node>();
    }
    new_node->next = _front;
    new (&new_node->value) T(args...);
    _front = new_node;
}

template <typename T> void ForwardList<T>::pop_front() {
    if (_front == nullptr) {
        return;
    }

    Node *next = _front->next;
    T value = _front->value;

    _front->next = _spare;
    _spare = _front;

    _front = next;
}

} /* namespace util */

OAG_ASSUME_NONNULL_END

#endif /* UTILITIES_FORWARD_LIST_HPP */
