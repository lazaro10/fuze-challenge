import Foundation

final class DispatchQueue {
    public static let main = DispatchQueue(underlyingQueue: Foundation.DispatchQueue.main)

    private let underlyingQueue: Foundation.DispatchQueue

    init(underlyingQueue: Foundation.DispatchQueue) {
        self.underlyingQueue = underlyingQueue
    }

    func async(_ function: @escaping () -> Void) {
        if let overriddenAsyncHandler = DispatchQueueTestingOverrides.overriddenAsyncHandler {
            overriddenAsyncHandler(function)
            return
        }
        underlyingQueue.async(execute: function)
    }
}

struct DispatchQueueTestingOverrides {
    static var overriddenAsyncHandler: ((_ closure: @escaping () -> ()) -> ())?
}
