# Qt4 and Qt5 tests
ADD_AUTOGEN_TEST(AutogenOriginDependsOff autogenOriginDependsOff)
ADD_AUTOGEN_TEST(AutogenOriginDependsOn)
ADD_AUTOGEN_TEST(AutogenTargetDepends)
ADD_AUTOGEN_TEST(Complex QtAutogen)
ADD_AUTOGEN_TEST(GlobalAutogenTarget)
ADD_AUTOGEN_TEST(LowMinimumVersion lowMinimumVersion)
ADD_AUTOGEN_TEST(ManySources manySources)
ADD_AUTOGEN_TEST(MocOnly mocOnly)
ADD_AUTOGEN_TEST(MocOptions mocOptions)
ADD_AUTOGEN_TEST(ObjectLibrary someProgram)
ADD_AUTOGEN_TEST(Parallel parallel)
ADD_AUTOGEN_TEST(Parallel1 parallel1)
ADD_AUTOGEN_TEST(Parallel2 parallel2)
ADD_AUTOGEN_TEST(Parallel3 parallel3)
ADD_AUTOGEN_TEST(Parallel4 parallel4)
ADD_AUTOGEN_TEST(ParallelAUTO parallelAUTO)
ADD_AUTOGEN_TEST(RccEmpty rccEmpty)
ADD_AUTOGEN_TEST(RccOffMocLibrary)
ADD_AUTOGEN_TEST(RccOnly rccOnly)
ADD_AUTOGEN_TEST(RccSkipSource)
ADD_AUTOGEN_TEST(RerunMocBasic)
ADD_AUTOGEN_TEST(RerunRccConfigChange)
ADD_AUTOGEN_TEST(RerunRccDepends)
ADD_AUTOGEN_TEST(SameName sameName)
ADD_AUTOGEN_TEST(StaticLibraryCycle slc)
ADD_AUTOGEN_TEST(UicInclude uicInclude)
ADD_AUTOGEN_TEST(UicInterface QtAutoUicInterface)
ADD_AUTOGEN_TEST(UicNoGui uicNoGui)
ADD_AUTOGEN_TEST(UicOnly uicOnly)
ADD_AUTOGEN_TEST(UicSkipSource)
ADD_AUTOGEN_TEST(UnityMocSource)

if(QT_TEST_ALLOW_QT_MACROS)
  ADD_AUTOGEN_TEST(MocCMP0071)
  ADD_AUTOGEN_TEST(MocCMP0100)
  ADD_AUTOGEN_TEST(MocInclude)
  ADD_AUTOGEN_TEST(MocIncludeSymlink)
  ADD_AUTOGEN_TEST(MocSkipSource)
endif()

# Qt5 only tests
if(QT_TEST_VERSION GREATER 4)
  ADD_AUTOGEN_TEST(MocMacroName mocMacroName)
  ADD_AUTOGEN_TEST(MocOsMacros)
  ADD_AUTOGEN_TEST(RerunMocPlugin)
  if(APPLE)
    ADD_AUTOGEN_TEST(MacOsFW)
  endif()
endif()
