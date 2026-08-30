import Foundation

enum DockPanelZoomCommand {
    case increase
    case decrease
    case reset
}

extension DockSplitStore {
    /// Applies a zoom command to an explicitly captured Dock panel. Browser,
    /// Markdown preview, and text-file preview panels share this mutation path
    /// so command-palette routing cannot fall through to the main workspace.
    @discardableResult
    func performDockPanelZoom(
        _ command: DockPanelZoomCommand,
        panelId: UUID? = nil
    ) -> Bool {
        guard !isRetired,
              let targetPanelId = panelId ?? focusedPanelId,
              let panel = panels[targetPanelId] else {
            return false
        }

        switch panel {
        case let browser as BrowserPanel:
            switch command {
            case .increase:
                return browser.zoomIn()
            case .decrease:
                return browser.zoomOut()
            case .reset:
                return browser.resetZoom()
            }
        case let markdown as MarkdownPanel where markdown.displayMode == .preview:
            switch command {
            case .increase:
                return markdown.zoomIn()
            case .decrease:
                return markdown.zoomOut()
            case .reset:
                return markdown.resetZoom()
            }
        case let filePreview as FilePreviewPanel where filePreview.previewMode == .text:
            switch command {
            case .increase:
                return filePreview.zoomTextPreviewIn()
            case .decrease:
                return filePreview.zoomTextPreviewOut()
            case .reset:
                return filePreview.resetTextPreviewZoom()
            }
        default:
            return false
        }
    }
}
