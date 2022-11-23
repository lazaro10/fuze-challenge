//
//  DispatchQueueTestingOverrides.swift
//  fuze
//
//  Created by Firenze on 23/11/22.
//

//import Foundation

//import extension DispatchQueue {
//    as
//}

//
//#if DEBUG
//    /// Overridden date and time related properties
//    public struct DispatchQueueTestingOverrides {
//        /// Lets TestCase handle all async calls to all DispatchQueue.
//        public static var overriddenAsyncHandler: ((_ closure: @escaping () -> ()) -> ())?
//        /// Lets TestCase handle all DispatchWorkItems in DispatchQueue.
//        public static var overriddenAsyncWorkItemHandler: ((_ workItem: DispatchWorkItem) -> ())?
//    }
//
//public final class DispatchQueue {
//
//    /// The main thread serial queue.
//    public static let main = DispatchQueue(underlyingQueue: Foundation.DispatchQueue.main)
//
//    /// This concurrent queue is usually used to perform high priority user interaction work that are virtually
//    /// instantaneous.
//    ///
//    /// Work that is interacting with the user, such as operating on the main thread, refreshing the user interface,
//    /// or performing animations. If the work doesn’t happen quickly, the user interface may appear frozen.
//    /// Focuses on responsiveness and performance.
//    ///
//    /// - Warning: THE MAIN THREAD TENDS TO HAVE A LOWER PRIORITY THAN THE USER INTERACTIVE LEVEL,
//    ///   WHICH MEANS CODE IN THIS THREAD WILL TEND TO BLOCK THE MAIN THREAD.
//    public static let userInteractive = DispatchQueue(underlyingQueue: Foundation.DispatchQueue.global(qos: .userInteractive))
//
//    /// A concurrent queue that is used to perform high priority work that are nearly instantaneous such as a few
//    /// seconds or less.
//    ///
//    /// Work that the user has initiated and requires immediate results, such as opening a saved document or
//    /// performing an action when the user clicks something in the user interface. The work is required in
//    /// order to continue user interaction. Focuses on responsiveness and performance.
//    public static let userInitiated = DispatchQueue(underlyingQueue: Foundation.DispatchQueue.global(qos: .userInitiated))
//
//    /// This concurrent queue is usually used to perform low priority work.
//    ///
//    /// Work that may take some time to complete and doesn’t require an immediate result, such as downloading or
//    /// importing data. Utility tasks typically have a progress bar that is visible to the user.
//    /// Focuses on providing a balance between responsiveness, performance, and energy efficiency.
//    public static let utility = DispatchQueue(underlyingQueue: Foundation.DispatchQueue.global(qos: .utility))
//
//    /// Describes the quality of service for a DispatchQueue
//    public enum QualityOfService {
//        /// A queue of this quality of service is best used for animations and refreshing the user interface.
//        /// Work scheduled should be instantaneous.
//        ///
//        /// - Warning: THE MAIN THREAD TENDS TO HAVE A LOWER PRIORITY THAN THE USER INTERACTIVE LEVEL,
//        ///   WHICH MEANS CODE IN THIS THREAD WILL TEND TO BLOCK THE MAIN THREAD.
//        case userInteractive
//
//        /// A queue of this quality of service is best used for work that requires immediate results, such performing
//        /// some action when the user clicks
//        /// on a button. Work scheduled should return almost instantaneously, within a few seconds or less.
//        case userInitiated
//
//        /// A queue of this quality of service is best used for work that doesn't require immediate results, such us
//        /// downloading resources. Work scheduled usually takes a few seconds to a few minutes.
//        case utility
//
//        fileprivate var dispatchQoS: DispatchQoS {
//            switch self {
//            case .userInteractive: return .userInteractive
//            case .userInitiated: return .userInitiated
//            case .utility: return .utility
//            }
//        }
//    }
//
//    /// The underlying Foundation.DispatchQueue.
//    public let underlyingQueue: Foundation.DispatchQueue
//
//    #if DEBUG
//        /// Suspension count that increases with calls to suspend() and decreases with calls to resume().
//        private var suspensionCount = 0
//    #endif
//
//    /// Initializer.
//    ///
//    /// - parameter queue: The underlying Foundation.DispatchQueue to use.
//    public init(underlyingQueue: Foundation.DispatchQueue) {
//        self.underlyingQueue = underlyingQueue
//    }
//
//    /// Initializer.
//    ///
//    /// - parameter label: The name of the queue
//    /// - parameter qualityOfService: The quality of service that you want to create the queue with.
//    /// - parameter concurrent: Whether the queue is concurrent or serial (default).
//    public init(label: String, qualityOfService: QualityOfService, concurrent: Bool = false) {
//        if concurrent {
//            underlyingQueue = Foundation.DispatchQueue(label: label, qos: qualityOfService.dispatchQoS, attributes: .concurrent)
//        } else {
//            underlyingQueue = Foundation.DispatchQueue(label: label, qos: qualityOfService.dispatchQoS)
//        }
//    }
//
//    /// Executes a closure asynchronously on the queue.
//    ///
//    /// - Note: When this function gets executes as part of a unit test run managed by a TestCase, the closure
//    ///   does not get executed automatically. It is queued up on the main thread and the test needs to call
//    ///   TestCase.advanceAsyncClosures(by:) to execute the queued up closures on the main thread.
//    ///
//    /// - parameter delay: An optional delay. Defaults to 0.
//    /// - parameter closure: The closure to invoke.
//    public func async(delay: TimeInterval = 0, _ closure: @escaping () -> ()) {
//        #if DEBUG
//            if let overriddenAsyncHandler = DispatchQueueTestingOverrides.overriddenAsyncHandler {
//                overriddenAsyncHandler(closure)
//                return
//            }
//        #endif
//        if delay == 0 {
//            underlyingQueue.async(execute: closure)
//        } else {
//            let deadline = DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(delay * 1000))
//            underlyingQueue.asyncAfter(deadline: deadline, execute: closure)
//        }
//    }
//
//    /// Executes a DispatchWorkItem asynchronously on the queue.
//    ///
//    /// - Note: When this function gets executes as part of a unit test run managed by a TestCase, the DispatchWorkItem
//    ///   does not get executed automatically. It is queued up on the main thread and the test needs to call
//    ///   TestCase.advanceAsyncClosures(by:) to execute the queued up closures on the main thread.
//    ///
//    /// - parameter delay: An optional delay. Defaults to 0.
//    /// - parameter workItem: The DispatchWorkItem to invoke. This may be cancelled
//    public func async(delay: TimeInterval = 0, workItem: DispatchWorkItem) {
//        #if DEBUG
//            if let overriddenAsyncWorkItemHandler = DispatchQueueTestingOverrides.overriddenAsyncWorkItemHandler {
//                overriddenAsyncWorkItemHandler(workItem)
//                return
//            }
//        #endif
//        if delay == 0 {
//            underlyingQueue.async(execute: workItem)
//        } else {
//            let deadline = DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(delay * 1000))
//            underlyingQueue.asyncAfter(deadline: deadline, execute: workItem)
//        }
//    }
//
//    /// Executes a closure synchronously on the queue.
//    ///
//    /// - parameter closure: The closure to invoke.
//    /// - returns: Whatever the closure returns
//    public func sync<T>(_ closure: () -> T) -> T {
//        var result: T?
//        underlyingQueue.sync {
//            result = closure()
//        }
//        // We know that the closure provided a value of type T
//        return result!
//    }
//
//    /// Executes a barrier closure asynchronously on the queue. If the queue is serial, this has the same effect as
//    /// calling async.
//    ///
//    /// On concurrent queues, when the closure reaches the front of the queue, it is not executed immediately.
//    /// Instead, the queue waits until its currently executing blocks finish executing. At that point, the barrier
//    /// closure executes by itself. Any blocks submitted after the barrier closure are not executed until the barrier
//    /// closure completes.
//    ///
//    /// - parameter closure: The barrier closure to invoke.
//    public func asyncBarrier(_ closure: @escaping () -> ()) {
//        #if DEBUG
//            if let overriddenAsyncHandler = DispatchQueueTestingOverrides.overriddenAsyncHandler {
//                overriddenAsyncHandler(closure)
//                return
//            }
//        #endif
//        underlyingQueue.async(flags: .barrier, execute: closure)
//    }
//
//    /// Stalls the calling thread until the queue has drained.
//    ///
//    /// - parameter completion: The closure to execute when the queue is drained.
//    /// - note: Thi
//
//    public func waitForQueueToDrain(_ completion: (() -> ())? = nil) {
//        underlyingQueue.sync(flags: .barrier) {
//            completion?()
//        }
//    }
//
//    /// Suspends the invocation of block objects on a dispatch queue.
//    public func suspend() {
//        underlyingQueue.suspend()
//        #if DEBUG
//            suspensionCount += 1
//        #endif
//    }
//
//    /// Resume the invocation of block objects on a dispatch queue.
//    public func resume() {
//        underlyingQueue.resume()
//        #if DEBUG
//            suspensionCount -= 1
//        #endif
//    }
//
//    #if DEBUG
//        public func isSuspended() -> Bool {
//            suspensionCount > 0
//        }
//    #endif
//}
//
//#if DEBUG
//    /// Overridden date and time related properties
//    public struct DispatchQueueTestingOverrides {
//        /// Lets TestCase handle all async calls to all DispatchQueue.
//        public static var overriddenAsyncHandler: ((_ closure: @escaping () -> ()) -> ())?
//        /// Lets TestCase handle all DispatchWorkItems in DispatchQueue.
//        public static var overriddenAsyncWorkItemHandler: ((_ workItem: DispatchWorkItem) -> ())?
//    }
//#endif
//`
