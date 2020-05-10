/* Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
   file Copyright.txt or https://cmake.org/licensing for details.  */
#ifndef cmVSSetupHelper_h
#define cmVSSetupHelper_h

#ifndef NOMINMAX
#  define NOMINMAX // Undefine min and max defined by windows.h
#endif

// Published by Visual Studio Setup team
#include <cm3p/Setup.Configuration.h>
#include <string>
#include <vector>

#include <windows.h>

template <class T>
class SmartCOMPtr
{
public:
  SmartCOMPtr() { ptr = NULL; }
  SmartCOMPtr(T* p)
  {
    ptr = p;
    if (ptr != NULL)
      ptr->AddRef();
  }
  SmartCOMPtr(const SmartCOMPtr<T>& sptr)
  {
    ptr = sptr.ptr;
    if (ptr != NULL)
      ptr->AddRef();
  }
  T** operator&() { return &ptr; }
  T* operator->() { return ptr; }
  T* operator=(T* p)
  {
    if (*this != p) {
      ptr = p;
      if (ptr != NULL)
        ptr->AddRef();
    }
    return *this;
  }
  operator T*() const { return ptr; }
  template <class I>
  HRESULT QueryInterface(REFCLSID rclsid, I** pp)
  {
    if (pp != NULL) {
      return ptr->QueryInterface(rclsid, (void**)pp);
    } else {
      return E_FAIL;
    }
  }
  HRESULT CoCreateInstance(REFCLSID clsid, IUnknown* pUnknown,
                           REFIID interfaceId, DWORD dwClsContext = CLSCTX_ALL)
  {
    HRESULT hr = ::CoCreateInstance(clsid, pUnknown, dwClsContext, interfaceId,
                                    (void**)&ptr);
    return hr;
  }
  ~SmartCOMPtr()
  {
    if (ptr != NULL)
      ptr->Release();
  }

private:
  T* ptr;
};

class SmartBSTR
{
public:
  SmartBSTR() { str = NULL; }
  SmartBSTR(const SmartBSTR& src) = delete;
  SmartBSTR& operator=(const SmartBSTR& src) = delete;
  operator BSTR() const { return str; }
  BSTR* operator&() throw() { return &str; }
  ~SmartBSTR() throw() { ::SysFreeString(str); }

private:
  BSTR str;
};

struct VSInstanceInfo
{
  std::wstring InstanceId;
  std::wstring VSInstallLocation;
  std::wstring Version;
  std::string VCToolsetVersion;
  ULONGLONG ullVersion = 0;
  bool IsWin10SDKInstalled = false;
  bool IsWin81SDKInstalled = false;

  std::string GetInstallLocation() const;
};

class cmVSSetupAPIHelper
{
public:
  cmVSSetupAPIHelper(unsigned int version);
  ~cmVSSetupAPIHelper();

  bool SetVSInstance(std::string const& vsInstallLocation);

  bool IsVSInstalled();
  bool GetVSInstanceInfo(std::string& vsInstallLocation);
  bool GetVCToolsetVersion(std::string& vsToolsetVersion);
  bool IsWin10SDKInstalled();
  bool IsWin81SDKInstalled();

private:
  bool Initialize();
  bool GetVSInstanceInfo(SmartCOMPtr<ISetupInstance2> instance2,
                         VSInstanceInfo& vsInstanceInfo);
  bool CheckInstalledComponent(SmartCOMPtr<ISetupPackageReference> package,
                               bool& bWin10SDK, bool& bWin81SDK);
  int ChooseVSInstance(const std::vector<VSInstanceInfo>& vecVSInstances);
  bool EnumerateAndChooseVSInstance();

  unsigned int Version;

  // COM ptrs to query about VS instances
  SmartCOMPtr<ISetupConfiguration> setupConfig;
  SmartCOMPtr<ISetupConfiguration2> setupConfig2;
  SmartCOMPtr<ISetupHelper> setupHelper;
  // used to indicate failure in Initialize(), so we don't have to call again
  bool initializationFailure;
  // indicated if COM initialization is successful
  HRESULT comInitialized;
  // current best instance of VS selected
  VSInstanceInfo chosenInstanceInfo;
  bool IsEWDKEnabled();

  std::string SpecifiedVSInstallLocation;
};

#endif
