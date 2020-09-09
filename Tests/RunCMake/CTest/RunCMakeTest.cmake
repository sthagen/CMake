include(RunCMake)

set(RunCMake_TEST_OPTIONS -DNoProject=1)
run_cmake(BeforeProject)
unset(RunCMake_TEST_OPTIONS)

run_cmake(NotOn)

function(run_CMakeCTestArguments)
  run_cmake_with_options(CMakeCTestArguments "-DCMAKE_CTEST_ARGUMENTS=--quiet\\;--output-log\\;output-log.txt")
  set(RunCMake_TEST_NO_CLEAN 1)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/CMakeCTestArguments-build)
  if(RunCMake_GENERATOR MATCHES "Make|Ninja")
    set(test "test")
  else()
    set(test "RUN_TESTS")
  endif()
  run_cmake_command(CMakeCTestArguments-test ${CMAKE_COMMAND} --build . --config Debug --target "${test}")
endfunction()
run_CMakeCTestArguments()

function(run_TestfileErrors)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/TestfileErrors-build)
  run_cmake(TestfileErrors)
  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(TestfileErrors-build ${CMAKE_COMMAND} --build . --config Debug)
  run_cmake_command(TestfileErrors-test ${CMAKE_CTEST_COMMAND} -C Debug)
endfunction()
run_TestfileErrors()
