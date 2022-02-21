﻿#include "FrameApi.h"

CKLEXPORT void WINAPI Chrome_FrameLoadUrl(CefFrame* frame, wchar_t* url) {
	if (frame)
		frame->LoadURL(url);
}

CKLEXPORT void WINAPI Chrome_FrameLoadString(CefFrame* frame, wchar_t* string, wchar_t* url) {
	/*if (frame)
		if (!url)
			frame->LoadString(string, frame->GetURL());
		else frame->LoadString(string, url);*/
}

CKLEXPORT void WINAPI Chrome_FrameExecJS(CefFrame* frame, wchar_t* js_code, wchar_t* url) {
	if (frame)
		if (!url)
			frame->ExecuteJavaScript(js_code, frame->GetURL(), 0);
		else frame->ExecuteJavaScript(js_code, url, 0);
}

CKLEXPORT void WINAPI Chrome_FrameLoadRequest(CefFrame* frame, wchar_t* url, wchar_t* method, wchar_t* referrer, void* postdata, size_t postdata_len) {
	if (frame) {
		CefRefPtr<CefRequest> request = CefRequest::Create();
		CefRefPtr<CefPostData> _postdata = CefPostData::Create();
		CefRefPtr<CefPostDataElement> element = CefPostDataElement::Create();

		if (postdata_len) {
			element->SetToBytes(postdata_len, postdata);
			_postdata->AddElement(element);

			request->SetPostData(_postdata);
		}

		request->SetFlags(0);
		request->SetMethod(CefString(method));
		request->SetURL(CefString(url));
		//if (referrer) request->SetReferrer(CefString(referrer), REFERRER_POLICY_ALWAYS);

		frame->LoadRequest(request);
	}
}

CKLEXPORT bool WINAPI Chrome_FrameIsMain(CefFrame* frame) {
	if (frame)
		return frame->IsMain();
	return 0;
}

CKLEXPORT void WINAPI Chrome_ReleaseFrame(CefFrame* frame) {
	if (frame)
		frame->Release();
}

CKLEXPORT wchar_t* WINAPI Chrome_FrameGetUrl(CefFrame* lpFrame) {
	if (lpFrame) {
		std::wstring strFrameUrl = lpFrame->GetURL().ToWString();
		wchar_t* lpBuffer = new wchar_t[strFrameUrl.length() + 1];
		_ECKL_CopyWString(strFrameUrl, lpBuffer, (strFrameUrl.length() + 1) * sizeof(wchar_t));
		return lpBuffer;
	}
	return 0;
}

CKLEXPORT CefFrame* WINAPI Chrome_GetNameFrame(SimpleHandler* handler, wchar_t* name) {
	if (handler) {
		CefRefPtr<CefBrowser> browser = handler->g_browser;
		if (browser && browser.get()) {
			CefRefPtr<CefFrame> frame = browser->GetFrame(CefString(std::wstring(name)));
			if (frame) {
				CefFrame* lpFrame = frame.get();
				lpFrame->AddRef();
				return lpFrame;
			}
		}
	}
	return 0;
}

CKLEXPORT CefFrame* WINAPI EcQBIGetMainFrame(SimpleHandler* handler) {
	CefFrame* main;
	Chrome_QueryBrowserInfomation(handler, BrowserInfomationMainFrame, &main);
	return main;
}

CKLEXPORT void WINAPI Chrome_FrameDoCopy(CefFrame* frame) {
	if (frame)
		frame->Copy();
}

CKLEXPORT void WINAPI Chrome_FrameDoCut(CefFrame* frame) {
	if (frame)
		frame->Cut();
}

CKLEXPORT void WINAPI Chrome_FrameDoDelete(CefFrame* frame) {
	if (frame)
		frame->Delete();
}

CKLEXPORT void WINAPI Chrome_FrameDoPaste(CefFrame* frame) {
	if (frame)
		frame->Paste();
}

CKLEXPORT void WINAPI Chrome_FrameDoSelectAll(CefFrame* frame) {
	if (frame)
		frame->SelectAll();
}
