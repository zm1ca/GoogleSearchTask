//
//  AsyncOperation.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 18.11.21.
//
// Credits to http://www.patrickm.io/blog/2017/05/28/swift-networking-operations.html

import Foundation

class AsyncOperation: Operation {
    // MARK: - State
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    // MARK: - Operation Overrides
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    // MARK: - Start
    override func start() {
      if isCancelled {
        state = .finished
        return
      }

      // Execute the main function of the Operation
      main()
      state = .executing
    }

    // MARK: - Cancel
    override func cancel() {
      super.cancel()
      state = .finished
    }
}
