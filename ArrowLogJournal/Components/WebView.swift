import SwiftUI
import WebKit

struct WebView: View {
    
    let url: URL
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            BrowserView(url: url)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var header: some View {
        HStack {
            Button(action: onBack) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: 50)
        .background(Color.black)
    }
}

struct BrowserView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.bounces = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url != url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

#Preview {
    WebView(url: URL(string: "https://apple.com")!) {
        print("Back pressed")
    }
}
