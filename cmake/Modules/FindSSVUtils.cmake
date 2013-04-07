set(FIND_SSVUTILS_LIB_NAMES SSVUtils libSSVUtils ssvutils libssvutils)

set(FIND_SSVUTILS_LIB_PATHS
	"${PROJECT_SOURCE_DIR}/../SSVUtils/"
	"${PROJECT_SOURCE_DIR}/extlibs/SSVUtils/"
	${SSVUTILS_ROOT}
	$ENV{SSVUTILS_ROOT}
	~/Library/Frameworks
	/Library/Frameworks
	/usr/local
	/usr/
	/sw/
	/opt/local
	/opt/csw
	/opt
)

FIND_PATH(SSVUTILS_INCLUDE_DIR
	NAMES SSVUtils/SSVUtils.h
	PATH_SUFFIXES include/
	PATHS ${FIND_SSVUTILS_LIB_PATHS}
)
MESSAGE("\nFound SSVUtils include at: ${SSVUTILS_INCLUDE_DIR}.\n")

FIND_LIBRARY(SSVUTILS_LIBRARY_RELEASE
	NAMES ${FIND_SSVUTILS_LIB_NAMES} ${FIND_SSVUTILS_LIB_NAMES}-s
	PATH_SUFFIXES lib/ lib64/
	PATHS ${FIND_SSVUTILS_LIB_PATHS}
)
MESSAGE("\nFound SSVUtils release library at: ${SSVUTILS_LIBRARY_RELEASE}.\n")

FIND_LIBRARY(SSVUTILS_LIBRARY_DEBUG
	NAMES ${FIND_SSVUTILS_LIB_NAMES}-d ${FIND_SSVUTILS_LIB_NAMES}-s-d
	PATH_SUFFIXES lib/ lib64/
	PATHS ${FIND_SSVUTILS_LIB_PATHS}
)
MESSAGE("\nFound SSVUtils debug library at: ${SSVUTILS_LIBRARY_DEBUG}.\n")

if(SSVUTILS_LIBRARY_DEBUG OR SSVUTILS_LIBRARY_RELEASE)
	set(SSVUTILS_FOUND TRUE)
	if(SSVUTILS_LIBRARY_DEBUG AND SSVUTILS_LIBRARY_RELEASE)
		SET(SSVUTILS_LIBRARY debug ${SSVUTILS_LIBRARY_DEBUG} optimized ${SSVUTILS_LIBRARY_RELEASE})
	endif()
	if(SSVUTILS_LIBRARY_DEBUG AND NOT SSVUTILS_LIBRARY_RELEASE)
		set(SSVUTILS_LIBRARY_RELEASE ${SSVUTILS_LIBRARY_DEBUG})
		set(SSVUTILS_LIBRARY         ${SSVUTILS_LIBRARY_DEBUG})
	endif()
	if(SSVUTILS_LIBRARY_RELEASE AND NOT SSVUTILS_LIBRARY_DEBUG)
		set(SSVUTILS_LIBRARY_DEBUG ${SSVUTILS_LIBRARY_RELEASE})
		set(SSVUTILS_LIBRARY       ${SSVUTILS_LIBRARY_RELEASE})
	endif()
else()
	set(SSVUTILS_FOUND FALSE)
	set(SSVUTILS_LIBRARY "")
endif()

IF(SSVUTILS_FOUND)
	MESSAGE(STATUS "\nFound SSVUTILS: ${SSVUTILS_LIBRARY}\n")
ELSE()
	IF(SSVUTILS_FIND_REQUIRED)
		MESSAGE(FATAL_ERROR "\nCould not find SSVUtils library\n")
	ENDIF(SSVUTILS_FIND_REQUIRED)
	set(SSVUTILS_ROOT "" CACHE PATH "SSVUtils top-level directory")
	message("\n-> SSVUtils directory not found. Set SSVUTILS_ROOT to SSVUtils' top-level path (containing both \"include\" and \"lib\" directories).")
ENDIF()

MARK_AS_ADVANCED(
	SSVUTILS_LIBRARY_DEBUG
	SSVUTILS_LIBRARY_RELEASE
	SSVUTILS_LIBRARY
	SSVUTILS_INCLUDE_DIR
)