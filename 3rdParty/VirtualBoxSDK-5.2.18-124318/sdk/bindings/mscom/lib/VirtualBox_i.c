#pragma warning(push) /* -Wall and windows.h */
#pragma warning(disable:4668 4255)
#if _MSC_VER >= 1800 /* RT_MSC_VER_VC120 */
# pragma warning(disable:4005)
#endif



/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 7.00.0555 */
/* at Tue Aug 14 12:13:48 2018
 */
/* Compiler settings for Z:\home\vbox\tinderbox\5.2-sdk\out\linux.amd64\release\bin\sdk\bindings\mscom\idl\VirtualBox.idl:
    Oicf, W4, Zp8, env=Win32 (32b run), target_arch=X86 7.00.0555 
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#pragma warning( disable: 4049 )  /* more than 64k source lines */


#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, IID_IVirtualBoxErrorInfo,0xc1bcc6d5,0x7966,0x481d,0xab,0x0b,0xd0,0xed,0x73,0xe2,0x81,0x35);


MIDL_DEFINE_GUID(IID, IID_INATNetwork,0x4bbc405d,0xf268,0x4483,0x9a,0x52,0xf4,0x3f,0xfd,0xbf,0x67,0xf8);


MIDL_DEFINE_GUID(IID, IID_IDHCPServer,0x00c8f974,0x92c5,0x44a1,0x8f,0x3f,0x70,0x24,0x69,0xfd,0xd0,0x4b);


MIDL_DEFINE_GUID(IID, IID_IVirtualBox,0x9570b9d5,0xf1a1,0x448a,0x10,0xc5,0xe1,0x2f,0x52,0x85,0xad,0xad);


MIDL_DEFINE_GUID(IID, IID_IVFSExplorer,0xfb220201,0x2fd3,0x47e2,0xa5,0xdc,0x2c,0x24,0x31,0xd8,0x33,0xcc);


MIDL_DEFINE_GUID(IID, IID_ICertificate,0x392f1de4,0x80e1,0x4a8a,0x93,0xa1,0x67,0xc5,0xf9,0x2a,0x83,0x8a);


MIDL_DEFINE_GUID(IID, IID_IAppliance,0x8398f026,0x4add,0x4474,0x5b,0xc3,0x2f,0x9f,0x21,0x40,0xb2,0x3e);


MIDL_DEFINE_GUID(IID, IID_IVirtualSystemDescription,0x316c99a2,0x405d,0x41af,0x85,0x08,0x46,0x88,0x91,0x44,0xd0,0x67);


MIDL_DEFINE_GUID(IID, IID_IUnattended,0x6f89464f,0x7193,0x426c,0xa4,0x1f,0x52,0x2e,0x8f,0x53,0x7f,0xa0);


MIDL_DEFINE_GUID(IID, IID_IInternalMachineControl,0xcdbc59df,0x4f4d,0x4cf2,0x80,0x9c,0x91,0x76,0x01,0x35,0x5a,0xfc);


MIDL_DEFINE_GUID(IID, IID_IBIOSSettings,0xf13f667d,0x3624,0x4ac5,0x99,0xc1,0x3d,0x98,0x2e,0xbd,0x8d,0x98);


MIDL_DEFINE_GUID(IID, IID_IPCIAddress,0xc984d15f,0xe191,0x400b,0x84,0x0e,0x97,0x0f,0x3d,0xad,0x72,0x96);


MIDL_DEFINE_GUID(IID, IID_IPCIDeviceAttachment,0x91f33d6f,0xe621,0x4f70,0xa7,0x7e,0x15,0xf0,0xe3,0xc7,0x14,0xd5);


MIDL_DEFINE_GUID(IID, IID_IMachine,0x85cd948e,0xa71f,0x4289,0x28,0x1e,0x0c,0xa7,0xad,0x48,0xcd,0x89);


MIDL_DEFINE_GUID(IID, IID_IEmulatedUSB,0x6e253ee8,0x477a,0x2497,0x67,0x59,0x88,0xb8,0x29,0x2a,0x5a,0xf0);


MIDL_DEFINE_GUID(IID, IID_IVRDEServerInfo,0xc39ef4d6,0x7532,0x45e8,0x96,0xda,0xeb,0x59,0x86,0xae,0x76,0xe4);


MIDL_DEFINE_GUID(IID, IID_IConsole,0x872da645,0x4a9b,0x1727,0xbe,0xe2,0x55,0x85,0x10,0x5b,0x9e,0xed);


MIDL_DEFINE_GUID(IID, IID_IHostNetworkInterface,0x455f8c45,0x44a0,0xa470,0xba,0x20,0x27,0x89,0x0b,0x96,0xdb,0xa9);


MIDL_DEFINE_GUID(IID, IID_IHostVideoInputDevice,0xe8c25d4d,0xac97,0x4c16,0xb3,0xe2,0x81,0xbd,0x8a,0x57,0xcc,0x27);


MIDL_DEFINE_GUID(IID, IID_IHost,0xafca788c,0x4477,0x787d,0x60,0xb2,0x3f,0xa7,0x0e,0x56,0xfb,0xbc);


MIDL_DEFINE_GUID(IID, IID_ISystemProperties,0x0eb668d2,0x495e,0x5a36,0x88,0x90,0x29,0x99,0x9b,0x5f,0x03,0x0c);


MIDL_DEFINE_GUID(IID, IID_IGuestOSType,0xb1336a0a,0x2546,0x4d99,0x8c,0xff,0x8e,0xfb,0x13,0x0c,0xfa,0x9d);


MIDL_DEFINE_GUID(IID, IID_IAdditionsFacility,0xf2f7fae4,0x4a06,0x81fc,0xa9,0x16,0x78,0xb2,0xda,0x1f,0xa0,0xe5);


MIDL_DEFINE_GUID(IID, IID_IDnDBase,0x4132147b,0x42f8,0xcd96,0x75,0x70,0x6a,0x88,0x00,0xe3,0x34,0x2c);


MIDL_DEFINE_GUID(IID, IID_IDnDSource,0xd23a9ca3,0x42da,0xc94b,0x8a,0xec,0x21,0x96,0x8e,0x08,0x35,0x5d);


MIDL_DEFINE_GUID(IID, IID_IGuestDnDSource,0xdedfb5d9,0x4c1b,0xedf7,0xfd,0xf3,0xc1,0xbe,0x68,0x27,0xdc,0x28);


MIDL_DEFINE_GUID(IID, IID_IDnDTarget,0xff5befc3,0x4ba3,0x7903,0x2a,0xa4,0x43,0x98,0x8b,0xa1,0x15,0x54);


MIDL_DEFINE_GUID(IID, IID_IGuestDnDTarget,0x50ce4b51,0x0ff7,0x46b7,0xa1,0x38,0x3c,0x6e,0x5a,0xc9,0x46,0xb4);


MIDL_DEFINE_GUID(IID, IID_IGuestSession,0x486fd828,0x4c6b,0x239b,0xa8,0x46,0xc4,0xbb,0x69,0xe4,0x10,0x38);


MIDL_DEFINE_GUID(IID, IID_IProcess,0x2e20707d,0x4325,0x9a83,0x83,0xcf,0x3f,0xaf,0x5b,0x97,0x45,0x7c);


MIDL_DEFINE_GUID(IID, IID_IGuestProcess,0x35cf4b3f,0x4453,0x4f3e,0xc9,0xb8,0x56,0x86,0x93,0x9c,0x80,0xb6);


MIDL_DEFINE_GUID(IID, IID_IDirectory,0xf73650f4,0x4506,0x50ca,0x04,0x5a,0x23,0xa0,0xe3,0x2e,0xa5,0x08);


MIDL_DEFINE_GUID(IID, IID_IGuestDirectory,0xcc830458,0x4974,0xa19c,0x4d,0xc6,0xcc,0x98,0xc2,0x26,0x96,0x26);


MIDL_DEFINE_GUID(IID, IID_IFile,0x14c66b23,0x404c,0xf24a,0x3c,0xc1,0xee,0x95,0x01,0xd4,0x4f,0x2a);


MIDL_DEFINE_GUID(IID, IID_IGuestFile,0x92f21dc0,0x44de,0x1653,0xb7,0x17,0x2e,0xbf,0x0c,0xa9,0xb6,0x64);


MIDL_DEFINE_GUID(IID, IID_IFsObjInfo,0xd344626e,0x4b0a,0x10bc,0x9c,0x2b,0x68,0x97,0x30,0x52,0xde,0x16);


MIDL_DEFINE_GUID(IID, IID_IGuestFsObjInfo,0x6620db85,0x44e0,0xca69,0xe9,0xe0,0xd4,0x90,0x7c,0xec,0xcb,0xe5);


MIDL_DEFINE_GUID(IID, IID_IGuest,0x13a11514,0x402e,0x022e,0x61,0x80,0xc3,0x94,0x4d,0xe3,0xf9,0xc8);


MIDL_DEFINE_GUID(IID, IID_IProgress,0xe0026dc0,0x0c55,0x47b1,0xaa,0x64,0xd3,0x40,0xa3,0x96,0xb4,0x18);


MIDL_DEFINE_GUID(IID, IID_ISnapshot,0x5732f030,0x4194,0xec8b,0xc7,0x61,0xe1,0xa9,0x93,0x27,0xe9,0xf0);


MIDL_DEFINE_GUID(IID, IID_IMediumAttachment,0x3785b3f7,0x7b5f,0x4000,0x88,0x42,0xad,0x0c,0xc6,0xab,0x30,0xb7);


MIDL_DEFINE_GUID(IID, IID_IMedium,0x4afe423b,0x43e0,0xe9d0,0x82,0xe8,0xce,0xb3,0x07,0x94,0x0d,0xda);


MIDL_DEFINE_GUID(IID, IID_IMediumFormat,0x10f337fb,0x422e,0xe57e,0x66,0x1b,0x09,0x98,0xac,0x30,0x91,0x75);


MIDL_DEFINE_GUID(IID, IID_IToken,0x20479eaf,0xd8ed,0x44cf,0x85,0xac,0xc8,0x3a,0x26,0xc9,0x5a,0x4d);


MIDL_DEFINE_GUID(IID, IID_IKeyboard,0xda91d4c9,0x4c02,0xfdb1,0xc5,0xac,0xd8,0x9e,0x22,0xe8,0x13,0x02);


MIDL_DEFINE_GUID(IID, IID_IMousePointerShape,0xe04e5545,0x4a0f,0xf9d2,0x5b,0xef,0xf9,0xb2,0x5b,0x65,0x57,0xed);


MIDL_DEFINE_GUID(IID, IID_IMouse,0xee35adb0,0x4748,0x3e12,0xe7,0xfd,0x5a,0xad,0x95,0x7b,0xba,0x0f);


MIDL_DEFINE_GUID(IID, IID_IDisplaySourceBitmap,0x0b78daeb,0xf52f,0x43b9,0x99,0xe8,0x4a,0x3c,0x22,0x6c,0xbe,0x2d);


MIDL_DEFINE_GUID(IID, IID_IFramebuffer,0x1e8d3f27,0xb45c,0x48ae,0x8b,0x36,0xd3,0x5e,0x83,0xd2,0x07,0xaa);


MIDL_DEFINE_GUID(IID, IID_IFramebufferOverlay,0xaf398a9a,0x6b76,0x4805,0x8f,0xab,0x00,0xa9,0xdc,0xf4,0x73,0x2b);


MIDL_DEFINE_GUID(IID, IID_IGuestScreenInfo,0x6b2f98f8,0x9641,0x4397,0x85,0x4a,0x04,0x04,0x39,0xd0,0x11,0x4b);


MIDL_DEFINE_GUID(IID, IID_IDisplay,0x76eed314,0x3c72,0x4bbb,0x95,0xcf,0x5e,0xb4,0x94,0x7a,0x40,0x41);


MIDL_DEFINE_GUID(IID, IID_INetworkAdapter,0xe925c2aa,0x4fe4,0xaaf6,0x91,0xc5,0xe9,0xb8,0xea,0x41,0x51,0xee);


MIDL_DEFINE_GUID(IID, IID_ISerialPort,0xcb0a4a29,0x43a3,0x9040,0x0c,0x25,0x34,0x84,0x5d,0xb7,0xb0,0x42);


MIDL_DEFINE_GUID(IID, IID_IParallelPort,0x788b87df,0x7708,0x444b,0x9e,0xef,0xc1,0x16,0xce,0x42,0x3d,0x39);


MIDL_DEFINE_GUID(IID, IID_IMachineDebugger,0x9c0f5269,0x47ae,0xee34,0xc2,0xfe,0x53,0xa1,0x6e,0x38,0x89,0x25);


MIDL_DEFINE_GUID(IID, IID_IUSBDeviceFilters,0x9709db9b,0x3346,0x49d6,0x8f,0x1c,0x41,0xb0,0xc4,0x78,0x4f,0xf2);


MIDL_DEFINE_GUID(IID, IID_IUSBController,0x0c293c51,0x4810,0xe174,0x4f,0x78,0x19,0x93,0x76,0xc6,0x3b,0xbe);


MIDL_DEFINE_GUID(IID, IID_IUSBDevice,0x5915d179,0x83c7,0x4f2b,0xa3,0x23,0x9a,0x97,0xf4,0x6f,0x4e,0x29);


MIDL_DEFINE_GUID(IID, IID_IUSBDeviceFilter,0x45587218,0x4289,0xef4e,0x8e,0x6a,0xe5,0xb0,0x78,0x16,0xb6,0x31);


MIDL_DEFINE_GUID(IID, IID_IHostUSBDevice,0xc19073dd,0xcc7b,0x431b,0x98,0xb2,0x95,0x1f,0xda,0x8e,0xab,0x89);


MIDL_DEFINE_GUID(IID, IID_IHostUSBDeviceFilter,0x01adb2d6,0xaedf,0x461c,0xbe,0x2c,0x99,0xe9,0x1b,0xda,0xd8,0xa1);


MIDL_DEFINE_GUID(IID, IID_IUSBProxyBackend,0xdfe56449,0x6989,0x4002,0x80,0xcf,0x36,0x07,0xf3,0x77,0xd4,0x0c);


MIDL_DEFINE_GUID(IID, IID_IAudioAdapter,0xaeccc0a8,0xe0a0,0x427f,0xb9,0x46,0xc4,0x20,0x63,0xf5,0x4d,0x81);


MIDL_DEFINE_GUID(IID, IID_IVRDEServer,0x6e758489,0x453a,0x6f98,0x9c,0xb9,0x2d,0xa2,0xcb,0x8e,0xab,0xb5);


MIDL_DEFINE_GUID(IID, IID_ISharedFolder,0x15aabe95,0xe594,0x4e18,0x92,0x22,0xb5,0xe8,0x3a,0x23,0xf1,0xda);


MIDL_DEFINE_GUID(IID, IID_IInternalSessionControl,0x747e397e,0x69c8,0x45a0,0x88,0xd9,0xf7,0xf0,0x70,0x96,0x07,0x18);


MIDL_DEFINE_GUID(IID, IID_ISession,0x7844aa05,0xb02e,0x4cdd,0xa0,0x4f,0xad,0xe4,0xa7,0x62,0xe6,0xb7);


MIDL_DEFINE_GUID(IID, IID_IStorageController,0x49b19d41,0x4a75,0x7bd5,0xc1,0x24,0x25,0x9a,0xcb,0xa3,0xc4,0x1d);


MIDL_DEFINE_GUID(IID, IID_IPerformanceMetric,0x81314d14,0xfd1c,0x411a,0x95,0xc5,0xe9,0xbb,0x14,0x14,0xe6,0x32);


MIDL_DEFINE_GUID(IID, IID_IPerformanceCollector,0xb14290ad,0xcd54,0x400c,0xb8,0x58,0x79,0x7b,0xcb,0x82,0x57,0x0e);


MIDL_DEFINE_GUID(IID, IID_INATEngine,0xc1cdb6bf,0x44cb,0xe334,0x66,0xfa,0x46,0x9a,0x17,0xfd,0x09,0xdf);


MIDL_DEFINE_GUID(IID, IID_IExtPackPlugIn,0xc8e667b2,0x4234,0x1f9c,0x65,0x08,0xaf,0xa9,0xce,0xa4,0xef,0xa1);


MIDL_DEFINE_GUID(IID, IID_IExtPackBase,0x4bd17415,0x4438,0x8657,0xe7,0x8e,0x80,0xa4,0x07,0x13,0xa2,0x3c);


MIDL_DEFINE_GUID(IID, IID_IExtPack,0x431685da,0x3618,0x4ebc,0xb0,0x38,0x83,0x3b,0xa8,0x29,0xb4,0xb2);


MIDL_DEFINE_GUID(IID, IID_IExtPackFile,0x4c7f4bf6,0x4671,0x2f75,0x0f,0xbb,0xa9,0x9f,0x62,0x18,0xcd,0xfc);


MIDL_DEFINE_GUID(IID, IID_IExtPackManager,0xedba9d10,0x45d8,0xb440,0x17,0x12,0x46,0xac,0x0c,0x9b,0xc4,0xc5);


MIDL_DEFINE_GUID(IID, IID_IBandwidthGroup,0x31587f93,0x2d12,0x4d7c,0xba,0x6d,0xce,0x51,0xd0,0xd5,0xb2,0x65);


MIDL_DEFINE_GUID(IID, IID_IBandwidthControl,0x48c7f4c0,0xc9d6,0x4742,0x95,0x7c,0xa6,0xfd,0x52,0xe8,0xc4,0xae);


MIDL_DEFINE_GUID(IID, IID_IVirtualBoxClient,0xd2937a8e,0xcb8d,0x4382,0x90,0xba,0xb7,0xda,0x78,0xa7,0x45,0x73);


MIDL_DEFINE_GUID(IID, IID_IEventSource,0x9b6e1aee,0x35f3,0x4f4d,0xb5,0xbb,0xed,0x0e,0xce,0xfd,0x85,0x38);


MIDL_DEFINE_GUID(IID, IID_IEventListener,0x67099191,0x32e7,0x4f6c,0x85,0xee,0x42,0x23,0x04,0xc7,0x1b,0x90);


MIDL_DEFINE_GUID(IID, IID_IEvent,0x0ca2adba,0x8f30,0x401b,0xa8,0xcd,0xfe,0x31,0xdb,0xe8,0x39,0xc0);


MIDL_DEFINE_GUID(IID, IID_IReusableEvent,0x69bfb134,0x80f6,0x4266,0x8e,0x20,0x16,0x37,0x1f,0x68,0xfa,0x25);


MIDL_DEFINE_GUID(IID, IID_IMachineEvent,0x92ed7b1a,0x0d96,0x40ed,0xae,0x46,0xa5,0x64,0xd4,0x84,0x32,0x5e);


MIDL_DEFINE_GUID(IID, IID_IMachineStateChangedEvent,0x5748F794,0x48DF,0x438D,0x85,0xEB,0x98,0xFF,0xD7,0x0D,0x18,0xC9);


MIDL_DEFINE_GUID(IID, IID_IMachineDataChangedEvent,0xabe94809,0x2e88,0x4436,0x83,0xd7,0x50,0xf3,0xe6,0x4d,0x05,0x03);


MIDL_DEFINE_GUID(IID, IID_IMediumRegisteredEvent,0x53fac49a,0xb7f1,0x4a5a,0xa4,0xef,0xa1,0x1d,0xd9,0xc2,0xa4,0x58);


MIDL_DEFINE_GUID(IID, IID_IMediumConfigChangedEvent,0xdd3e2654,0xa161,0x41f1,0xb5,0x83,0x48,0x92,0xf4,0xa9,0xd5,0xd5);


MIDL_DEFINE_GUID(IID, IID_IMachineRegisteredEvent,0xc354a762,0x3ff2,0x4f2e,0x8f,0x09,0x07,0x38,0x2e,0xe2,0x50,0x88);


MIDL_DEFINE_GUID(IID, IID_ISessionStateChangedEvent,0x714a3eef,0x799a,0x4489,0x86,0xcd,0xfe,0x8e,0x45,0xb2,0xff,0x8e);


MIDL_DEFINE_GUID(IID, IID_IGuestPropertyChangedEvent,0x3f63597a,0x26f1,0x4edb,0x8d,0xd2,0x6b,0xdd,0xd0,0x91,0x23,0x68);


MIDL_DEFINE_GUID(IID, IID_ISnapshotEvent,0x21637b0e,0x34b8,0x42d3,0xac,0xfb,0x7e,0x96,0xda,0xf7,0x7c,0x22);


MIDL_DEFINE_GUID(IID, IID_ISnapshotTakenEvent,0xd27c0b3d,0x6038,0x422c,0xb4,0x5e,0x6d,0x4a,0x05,0x03,0xd9,0xf1);


MIDL_DEFINE_GUID(IID, IID_ISnapshotDeletedEvent,0xc48f3401,0x4a9e,0x43f4,0xb7,0xa7,0x54,0xbd,0x28,0x5e,0x22,0xf4);


MIDL_DEFINE_GUID(IID, IID_ISnapshotRestoredEvent,0xf4d803b4,0x9b2d,0x4377,0xbf,0xe6,0x97,0x02,0xe8,0x81,0x51,0x6b);


MIDL_DEFINE_GUID(IID, IID_ISnapshotChangedEvent,0x07541941,0x8079,0x447a,0xa3,0x3e,0x47,0xa6,0x9c,0x79,0x80,0xdb);


MIDL_DEFINE_GUID(IID, IID_IMousePointerShapeChangedEvent,0xa6dcf6e8,0x416b,0x4181,0x8c,0x4a,0x45,0xec,0x95,0x17,0x7a,0xef);


MIDL_DEFINE_GUID(IID, IID_IMouseCapabilityChangedEvent,0x70e7779a,0xe64a,0x4908,0x80,0x4e,0x37,0x1c,0xad,0x23,0xa7,0x56);


MIDL_DEFINE_GUID(IID, IID_IKeyboardLedsChangedEvent,0x6DDEF35E,0x4737,0x457B,0x99,0xFC,0xBC,0x52,0xC8,0x51,0xA4,0x4F);


MIDL_DEFINE_GUID(IID, IID_IStateChangedEvent,0x4376693C,0xCF37,0x453B,0x92,0x89,0x3B,0x0F,0x52,0x1C,0xAF,0x27);


MIDL_DEFINE_GUID(IID, IID_IAdditionsStateChangedEvent,0xD70F7915,0xDA7C,0x44C8,0xA7,0xAC,0x9F,0x17,0x34,0x90,0x44,0x6A);


MIDL_DEFINE_GUID(IID, IID_INetworkAdapterChangedEvent,0x08889892,0x1EC6,0x4883,0x80,0x1D,0x77,0xF5,0x6C,0xFD,0x01,0x03);


MIDL_DEFINE_GUID(IID, IID_IAudioAdapterChangedEvent,0xD5ABC823,0x04D0,0x4DB6,0x8D,0x66,0xDC,0x2F,0x03,0x31,0x20,0xE1);


MIDL_DEFINE_GUID(IID, IID_ISerialPortChangedEvent,0x3BA329DC,0x659C,0x488B,0x83,0x5C,0x4E,0xCA,0x7A,0xE7,0x1C,0x6C);


MIDL_DEFINE_GUID(IID, IID_IParallelPortChangedEvent,0x813C99FC,0x9849,0x4F47,0x81,0x3E,0x24,0xA7,0x5D,0xC8,0x56,0x15);


MIDL_DEFINE_GUID(IID, IID_IStorageControllerChangedEvent,0x715212BF,0xDA59,0x426E,0x82,0x30,0x38,0x31,0xFA,0xA5,0x2C,0x56);


MIDL_DEFINE_GUID(IID, IID_IMediumChangedEvent,0x0FE2DA40,0x5637,0x472A,0x97,0x36,0x72,0x01,0x9E,0xAB,0xD7,0xDE);


MIDL_DEFINE_GUID(IID, IID_IClipboardModeChangedEvent,0xcac21692,0x7997,0x4595,0xa7,0x31,0x3a,0x50,0x9d,0xb6,0x04,0xe5);


MIDL_DEFINE_GUID(IID, IID_IDnDModeChangedEvent,0xb55cf856,0x1f8b,0x4692,0xab,0xb4,0x46,0x24,0x29,0xfa,0xe5,0xe9);


MIDL_DEFINE_GUID(IID, IID_ICPUChangedEvent,0x4da2dec7,0x71b2,0x4817,0x9a,0x64,0x4e,0xd1,0x2c,0x17,0x38,0x8e);


MIDL_DEFINE_GUID(IID, IID_ICPUExecutionCapChangedEvent,0xdfa7e4f5,0xb4a4,0x44ce,0x85,0xa8,0x12,0x7a,0xc5,0xeb,0x59,0xdc);


MIDL_DEFINE_GUID(IID, IID_IGuestKeyboardEvent,0x88394258,0x7006,0x40d4,0xb3,0x39,0x47,0x2e,0xe3,0x80,0x18,0x44);


MIDL_DEFINE_GUID(IID, IID_IGuestMouseEvent,0x179f8647,0x319c,0x4e7e,0x81,0x50,0xc5,0x83,0x7b,0xd2,0x65,0xf6);


MIDL_DEFINE_GUID(IID, IID_IGuestMultiTouchEvent,0xbe8a0eb5,0xf4f4,0x4dd0,0x9d,0x30,0xc8,0x9b,0x87,0x32,0x47,0xec);


MIDL_DEFINE_GUID(IID, IID_IGuestSessionEvent,0xb9acd33f,0x647d,0x45ac,0x8f,0xe9,0xf4,0x9b,0x31,0x83,0xba,0x37);


MIDL_DEFINE_GUID(IID, IID_IGuestSessionStateChangedEvent,0x327e3c00,0xee61,0x462f,0xae,0xd3,0x0d,0xff,0x6c,0xbf,0x99,0x04);


MIDL_DEFINE_GUID(IID, IID_IGuestSessionRegisteredEvent,0xb79de686,0xeabd,0x4fa6,0x96,0x0a,0xf1,0x75,0x6c,0x99,0xea,0x1c);


MIDL_DEFINE_GUID(IID, IID_IGuestProcessEvent,0x2405f0e5,0x6588,0x40a3,0x9b,0x0a,0x68,0xc0,0x5b,0xa5,0x2c,0x4b);


MIDL_DEFINE_GUID(IID, IID_IGuestProcessRegisteredEvent,0x1d89e2b3,0xc6ea,0x45b6,0x9d,0x43,0xdc,0x6f,0x70,0xcc,0x9f,0x02);


MIDL_DEFINE_GUID(IID, IID_IGuestProcessStateChangedEvent,0xc365fb7b,0x4430,0x499f,0x92,0xc8,0x8b,0xed,0x81,0x4a,0x56,0x7a);


MIDL_DEFINE_GUID(IID, IID_IGuestProcessIOEvent,0x9ea9227c,0xe9bb,0x49b3,0xbf,0xc7,0xc5,0x17,0x1e,0x93,0xef,0x38);


MIDL_DEFINE_GUID(IID, IID_IGuestProcessInputNotifyEvent,0x0de887f2,0xb7db,0x4616,0xaa,0xc6,0xcf,0xb9,0x4d,0x89,0xba,0x78);


MIDL_DEFINE_GUID(IID, IID_IGuestProcessOutputEvent,0xd3d5f1ee,0xbcb2,0x4905,0xa7,0xab,0xcc,0x85,0x44,0x8a,0x74,0x2b);


MIDL_DEFINE_GUID(IID, IID_IGuestFileEvent,0xc8adb7b0,0x057d,0x4391,0xb9,0x28,0xf1,0x4b,0x06,0xb7,0x10,0xc5);


MIDL_DEFINE_GUID(IID, IID_IGuestFileRegisteredEvent,0xd0d93830,0x70a2,0x487e,0x89,0x5e,0xd3,0xfc,0x96,0x79,0xf7,0xb3);


MIDL_DEFINE_GUID(IID, IID_IGuestFileStateChangedEvent,0xd37fe88f,0x0979,0x486c,0xba,0xa1,0x3a,0xbb,0x14,0x4d,0xc8,0x2d);


MIDL_DEFINE_GUID(IID, IID_IGuestFileIOEvent,0xb5191a7c,0x9536,0x4ef8,0x82,0x0e,0x3b,0x0e,0x17,0xe5,0xbb,0xc8);


MIDL_DEFINE_GUID(IID, IID_IGuestFileOffsetChangedEvent,0xe8f79a21,0x1207,0x4179,0x94,0xcf,0xca,0x25,0x00,0x36,0x30,0x8f);


MIDL_DEFINE_GUID(IID, IID_IGuestFileReadEvent,0x4ee3cbcb,0x486f,0x40db,0x91,0x50,0xde,0xee,0x3f,0xd2,0x41,0x89);


MIDL_DEFINE_GUID(IID, IID_IGuestFileWriteEvent,0xe062a915,0x3cf5,0x4c0a,0xbc,0x90,0x9b,0x8d,0x4c,0xc9,0x4d,0x89);


MIDL_DEFINE_GUID(IID, IID_IVRDEServerChangedEvent,0xa06fd66a,0x3188,0x4c8c,0x87,0x56,0x13,0x95,0xe8,0xcb,0x69,0x1c);


MIDL_DEFINE_GUID(IID, IID_IVRDEServerInfoChangedEvent,0xdd6a1080,0xe1b7,0x4339,0xa5,0x49,0xf0,0x87,0x81,0x15,0x59,0x6e);


MIDL_DEFINE_GUID(IID, IID_IVideoCaptureChangedEvent,0x6215d169,0x25dd,0x4719,0xab,0x34,0xc9,0x08,0x70,0x1e,0xfb,0x58);


MIDL_DEFINE_GUID(IID, IID_IUSBControllerChangedEvent,0x93BADC0C,0x61D9,0x4940,0xA0,0x84,0xE6,0xBB,0x29,0xAF,0x3D,0x83);


MIDL_DEFINE_GUID(IID, IID_IUSBDeviceStateChangedEvent,0x806da61b,0x6679,0x422a,0xb6,0x29,0x51,0xb0,0x6b,0x0c,0x6d,0x93);


MIDL_DEFINE_GUID(IID, IID_ISharedFolderChangedEvent,0xB66349B5,0x3534,0x4239,0xB2,0xDE,0x8E,0x15,0x35,0xD9,0x4C,0x0B);


MIDL_DEFINE_GUID(IID, IID_IRuntimeErrorEvent,0x883DD18B,0x0721,0x4CDE,0x86,0x7C,0x1A,0x82,0xAB,0xAF,0x91,0x4C);


MIDL_DEFINE_GUID(IID, IID_IEventSourceChangedEvent,0xe7932cb8,0xf6d4,0x4ab6,0x9c,0xbf,0x55,0x8e,0xb8,0x95,0x9a,0x6a);


MIDL_DEFINE_GUID(IID, IID_IExtraDataChangedEvent,0x024F00CE,0x6E0B,0x492A,0xA8,0xD0,0x96,0x84,0x72,0xA9,0x4D,0xC7);


MIDL_DEFINE_GUID(IID, IID_IVetoEvent,0x7c5e945f,0x2354,0x4267,0x88,0x3f,0x2f,0x41,0x7d,0x21,0x65,0x19);


MIDL_DEFINE_GUID(IID, IID_IExtraDataCanChangeEvent,0x245d88bd,0x800a,0x40f8,0x87,0xa6,0x17,0x0d,0x02,0x24,0x9a,0x55);


MIDL_DEFINE_GUID(IID, IID_ICanShowWindowEvent,0xadf292b0,0x92c9,0x4a77,0x9d,0x35,0xe0,0x58,0xb3,0x9f,0xe0,0xb9);


MIDL_DEFINE_GUID(IID, IID_IShowWindowEvent,0xB0A0904D,0x2F05,0x4D28,0x85,0x5F,0x48,0x8F,0x96,0xBA,0xD2,0xB2);


MIDL_DEFINE_GUID(IID, IID_INATRedirectEvent,0x24eef068,0xc380,0x4510,0xbc,0x7c,0x19,0x31,0x4a,0x73,0x52,0xf1);


MIDL_DEFINE_GUID(IID, IID_IHostPCIDevicePlugEvent,0xa0bad6df,0xd612,0x47d3,0x89,0xd4,0xdb,0x39,0x92,0x53,0x39,0x48);


MIDL_DEFINE_GUID(IID, IID_IVBoxSVCAvailabilityChangedEvent,0x97c78fcd,0xd4fc,0x485f,0x86,0x13,0x5a,0xf8,0x8b,0xfc,0xfc,0xdc);


MIDL_DEFINE_GUID(IID, IID_IBandwidthGroupChangedEvent,0x334df94a,0x7556,0x4cbc,0x8c,0x04,0x04,0x30,0x96,0xb0,0x2d,0x82);


MIDL_DEFINE_GUID(IID, IID_IGuestMonitorChangedEvent,0x0f7b8a22,0xc71f,0x4a36,0x8e,0x5f,0xa7,0x7d,0x01,0xd7,0x60,0x90);


MIDL_DEFINE_GUID(IID, IID_IGuestUserStateChangedEvent,0x39b4e759,0x1ec0,0x4c0f,0x85,0x7f,0xfb,0xe2,0xa7,0x37,0xa2,0x56);


MIDL_DEFINE_GUID(IID, IID_IStorageDeviceChangedEvent,0x232e9151,0xae84,0x4b8e,0xb0,0xf3,0x5c,0x20,0xc3,0x5c,0xaa,0xc9);


MIDL_DEFINE_GUID(IID, IID_INATNetworkChangedEvent,0x101ae042,0x1a29,0x4a19,0x92,0xcf,0x02,0x28,0x57,0x73,0xf3,0xb5);


MIDL_DEFINE_GUID(IID, IID_INATNetworkStartStopEvent,0x269d8f6b,0xfa1e,0x4cee,0x91,0xc7,0x6d,0x84,0x96,0xbe,0xa3,0xc1);


MIDL_DEFINE_GUID(IID, IID_INATNetworkAlterEvent,0xd947adf5,0x4022,0xdc80,0x55,0x35,0x6f,0xb1,0x16,0x81,0x56,0x04);


MIDL_DEFINE_GUID(IID, IID_INATNetworkCreationDeletionEvent,0x8d984a7e,0xb855,0x40b8,0xab,0x0c,0x44,0xd3,0x51,0x5b,0x45,0x28);


MIDL_DEFINE_GUID(IID, IID_INATNetworkSettingEvent,0x9db3a9e6,0x7f29,0x4aae,0xa6,0x27,0x5a,0x28,0x2c,0x83,0x09,0x2c);


MIDL_DEFINE_GUID(IID, IID_INATNetworkPortForwardEvent,0x2514881b,0x23d0,0x430a,0xa7,0xff,0x7e,0xd7,0xf0,0x55,0x34,0xbc);


MIDL_DEFINE_GUID(IID, IID_IHostNameResolutionConfigurationChangeEvent,0xf9b9e1cf,0xcb63,0x47a1,0x84,0xfb,0x02,0xc4,0x89,0x4b,0x89,0xa9);


MIDL_DEFINE_GUID(IID, IID_IProgressEvent,0xdaaf9016,0x1f04,0x4191,0xaa,0x2f,0x1f,0xac,0x96,0x46,0xae,0x4c);


MIDL_DEFINE_GUID(IID, IID_IProgressPercentageChangedEvent,0xf05d7e60,0x1bcf,0x4218,0x98,0x07,0x04,0xe0,0x36,0xcc,0x70,0xf1);


MIDL_DEFINE_GUID(IID, IID_IProgressTaskCompletedEvent,0xa5bbdb7d,0x8ce7,0x469f,0xa4,0xc2,0x64,0x76,0xf5,0x81,0xff,0x72);


MIDL_DEFINE_GUID(IID, LIBID_VirtualBox,0xd7569351,0x1750,0x46f0,0x93,0x6e,0xbd,0x12,0x7d,0x5b,0xc2,0x64);


MIDL_DEFINE_GUID(CLSID, CLSID_VirtualBox,0xB1A7A4F2,0x47B9,0x4A1E,0x82,0xB2,0x07,0xCC,0xD5,0x32,0x3C,0x3F);


MIDL_DEFINE_GUID(CLSID, CLSID_VirtualBoxClient,0xdd3fc71d,0x26c0,0x4fe1,0xbf,0x6f,0x67,0xf6,0x33,0x26,0x5b,0xba);


MIDL_DEFINE_GUID(CLSID, CLSID_Session,0x3C02F46D,0xC9D2,0x4F11,0xA3,0x84,0x53,0xF0,0xCF,0x91,0x72,0x14);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif




#pragma warning(pop)

