//
//  OnDemandResourcesManager.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 31.12.2022.
//

import UIKit

// swiftlint:disable vertical_parameter_alignment_on_call

public class OnDemandResourcesManager: NSObject {

    public static let shared = OnDemandResourcesManager()
    
    private var currentRequest: NSBundleResourceRequest?
    private var observation: Any?
    public var onChangeProgress: ((Double) -> Void)?
    public var onError: ((Error) -> Void)?
    
    public func requestSceneWith(isDownloaded: Bool, resources: Set<String>) async throws {
        guard !isDownloaded else { return }
        
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
        
        save()
        close()
    }
    
    private func save() {
        guard let currentRequest else { return }
        let documentsDirectory = URL.documentsDirectory
        let urls = currentRequest.bundle.urls(forResourcesWithExtension: nil, subdirectory: nil) ?? []
        for url in urls {
            do {
                if !url.isDirectory {
                    let newPath = documentsDirectory.appending(path: url.lastPathComponent)
                    try copy(url: url, to: newPath)
                }
            } catch {
                onError?(error)
            }
        }
    }
    
    private func copy(url: URL, to: URL) throws {
        if FileManager.default.fileExists(atPath: to.path) { return }
        try FileManager.default.copyItem(
            at: url,
            to: to)
    }
    
    public func close() {
        currentRequest?.endAccessingResources()
    }
    
    public func path(forResource: String, ofType: String) -> String? {
        let type = ofType.replacingOccurrences(of: ".", with: "")
        return URL.documentsDirectory.appending(path: "\(forResource).\(type)").path
    }
    
    private func log(_ progress: Progress) {
        onChangeProgress?(floor(progress.fractionCompleted * 100))
    }
}

public extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
