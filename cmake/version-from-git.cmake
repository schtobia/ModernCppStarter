# ---- retrieve version information from git ----
set(GIT_DEFAULT_VERSION "0.0.0")
execute_process(
  COMMAND git describe --tags --dirty --always
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE GIT_DESCRIBE_VERSION_STRING
  RESULT_VARIABLE GIT_DESCRIBE_ERROR_CODE
  OUTPUT_STRIP_TRAILING_WHITESPACE
)
if(GIT_DESCRIBE_ERROR_CODE EQUAL 0)
  string(REGEX MATCH "^v?([0-9]+)(\\.([0-9]+))?(\\.([0-9]+))?(\\.([0-9]+))?.*$" _
               "${GIT_DESCRIBE_VERSION_STRING}"
  )
  if(${CMAKE_MATCH_1})
    set(VERSION_STRING "${CMAKE_MATCH_1}")
    if(${CMAKE_MATCH_3})
      string(APPEND VERSION_STRING ".${CMAKE_MATCH_3}")
      if(${CMAKE_MATCH_5})
        string(APPEND VERSION_STRING ".${CMAKE_MATCH_5}")
        if(${CMAKE_MATCH_7})
          string(APPEND VERSION_STRING ".${CMAKE_MATCH_7}")
        endif(${CMAKE_MATCH_7})
      endif(${CMAKE_MATCH_5})
    endif(${CMAKE_MATCH_3})
  else(${CMAKE_MATCH_1})
    set(VERSION_STRING "${GIT_DEFAULT_VERSION}")
  endif(${CMAKE_MATCH_1})
endif()
