//
//  OnDemandResourcesManager.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 31.12.2022.
//

import UIKit

// swiftlint:disable vertical_parameter_alignment_on_call

public class OnDemandResourcesManager: NSObject {

    // MARK: - Properties
    public static let shared = OnDemandResourcesManager()
    
    private var currentRequest: NSBundleResourceRequest?
    private var observation: Any?
    public var onChangeProgress: ((Double) -> Void)?
    
    public func requestSceneWith(resources: Set<String>) async throws {
        let request = NSBundleResourceRequest(tags: resources)
        currentRequest = request
        request.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
        observation = request.progress.observe(
            \.fractionCompleted,
             options: [.initial, .new],
             changeHandler: { [weak self] model, _ in
                 self?.log(model)
             })
        
        request.bundle.setPreservationPriority(1, forTags: resources)
        
        let result = await request.conditionallyBeginAccessingResources()
        
        if !result {
            try await request.beginAccessingResources()
        }
    }
    
    public func close() {
        currentRequest?.endAccessingResources()
    }
    
    public func path(forResource: String, ofType: String) -> String? {
        return currentRequest?.bundle.path(forResource: forResource, ofType: ofType)
    }
    
    public func log(_ progress: Progress) {
        onChangeProgress?(floor(progress.fractionCompleted * 100))
    }
}
