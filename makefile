# Copyright daemon_process

INCLUDE = ..\cef\;$(INCLUDE)
	
OBJS = CKLMain.obj CustomizeJS.obj CustomizeScheme.obj EcPackApi.obj FrameApi.obj simple_app.obj simple_handler.obj simple_handler_win.obj

CLFLAGS = /nologo /EHsc /MT /c /MP /GS /GL /analyze- /W3 /Gy /Zc:wchar_t /Gm- /O2 /Zc:inline /fp:precise /D "V8_DEPRECATION_WARNINGS" /D "BLINK_SCALE_FILTERS_AT_RECORD_TIME" /D "WINVER=0x0602" /D "WIN32" /D "_WINDOWS" /D "NOMINMAX" /D "PSAPI_VERSION=1" /D "_CRT_RAND_S" /D "CERT_CHAIN_PARA_HAS_EXTRA_FIELDS" /D "WIN32_LEAN_AND_MEAN" /D "_ATL_NO_OPENGL" /D "_HAS_EXCEPTIONS=0" /D "_SECURE_ATL" /D "CHROMIUM_BUILD" /D "TOOLKIT_VIEWS=1" /D "USE_AURA=1" /D "USE_ASH=1" /D "USE_DEFAULT_RENDER_THEME=1" /D "USE_LIBJPEG_TURBO=1" /D "USE_MOJO=1" /D "ENABLE_ONE_CLICK_SIGNIN" /D "ENABLE_REMOTING=1" /D "ENABLE_WEBRTC=1" /D "ENABLE_PEPPER_CDMS" /D "ENABLE_CONFIGURATION_POLICY" /D "ENABLE_INPUT_SPEECH" /D "ENABLE_NOTIFICATIONS" /D "ENABLE_HIDPI=1" /D "ENABLE_EGLIMAGE=1" /D "__STD_C" /D "_CRT_SECURE_NO_DEPRECATE" /D "_SCL_SECURE_NO_DEPRECATE" /D "NTDDI_VERSION=0x06020000" /D "_USING_V110_SDK71_" /D "ENABLE_TASK_MANAGER=1" /D "ENABLE_EXTENSIONS=1" /D "ENABLE_PLUGIN_INSTALLATION=1" /D "ENABLE_PLUGINS=1" /D "ENABLE_SESSION_SERVICE=1" /D "ENABLE_THEMES=1" /D "ENABLE_AUTOFILL_DIALOG=1" /D "ENABLE_BACKGROUND=1" /D "ENABLE_AUTOMATION=1" /D "ENABLE_GOOGLE_NOW=1" /D "CLD_VERSION=2" /D "ENABLE_FULL_PRINTING=1" /D "ENABLE_PRINTING=1" /D "ENABLE_SPELLCHECK=1" /D "ENABLE_CAPTIVE_PORTAL_DETECTION=1" /D "ENABLE_APP_LIST=1" /D "ENABLE_SETTINGS_APP=1" /D "ENABLE_MANAGED_USERS=1" /D "ENABLE_MDNS=1" /D "ENABLE_SERVICE_DISCOVERY=1" /D "USING_CEF_SHARED" /D "__STDC_CONSTANT_MACROS" /D "__STDC_FORMAT_MACROS" /D "DYNAMIC_ANNOTATIONS_ENABLED=1" /D "WTF_USE_DYNAMIC_ANNOTATIONS=1" /D "_WIN32" /D "_WINDLL" /D "_UNICODE" /D "UNICODE" /WX /Zc:forScope /Gd /Oy- /Oi

OUT_DIR = build\

all: $(OUT_DIR)EasyCKL.dll SDK\EasyCKL.h

$(OUT_DIR)EasyCKL.dll : default $(OBJS) cefsimple.res
	link /nologo /DLL /LTCG /DEF:"..\Export.def" *.obj cefsimple.res /out:"EasyCKL.dll" /LIBPATH:"..\lib"
	cd ..

{..\}.cpp.obj:
	
	@cl $(CLFLAGS) $< /Fo:$@

cefsimple.res : ..\cefsimple.rc
	@rc /nologo /fo cefsimple.res ..\cefsimple.rc 

default:
	@if not exist "$(OUT_DIR)" mkdir $(OUT_DIR)
	@if not exist "$(OUT_DIR)libcef_dll_wrapper.lib" (cd cef & nmake & cd ..)
	cd $(OUT_DIR)

clean:
	del /f /q $(OUT_DIR)*.*

SDK\EasyCKL.h : mkheader.sh SDK\header.h.begin SDK\header.h.end ec_portable.h CKLMain.h CustomizeJS.h CustomizeScheme.h EcPackApi.h FrameApi.h browser.h
	@echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	@echo "!! Please use MinGW or Cygwin to run ./mkheader.sh script in !!"
	@echo "!! this path to create the SDK header file EasyCKL.h which   !!"
	@echo "!! will be used by Apps who based on EasyCKL                 !!"
	@echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"