
find_program(PYTHON_EXECUTABLE NAMES python HINTS c:/python27 c:/python26)

if(${PYTHON_EXECUTABLE} STREQUAL "PYTHON_EXECUTABLE-NOTFOUND")
    message(FATAL_ERROR "Cannot find Python.exe")
endif()

set(TEST_BITCOIN_SOURCES accounting_tests.cpp alert_tests.cpp allocator_tests.cpp base32_tests.cpp base58_tests.cpp base64_tests.cpp bignum_tests.cpp bloom_tests.cpp canonical_tests.cpp checkblock_tests.cpp Checkpoints_tests.cpp compress_tests.cpp DoS_tests.cpp getarg_tests.cpp key_tests.cpp miner_tests.cpp mruset_tests.cpp multisig_tests.cpp netbase_tests.cpp pmt_tests.cpp rpc_tests.cpp script_P2SH_tests.cpp script_tests.cpp serialize_tests.cpp sigopcount_tests.cpp test_bitcoin.cpp transaction_tests.cpp uint160_tests.cpp uint256_tests.cpp util_tests.cpp wallet_tests.cpp)
  #$(JSON_TEST_FILES) $(RAW_TEST_FILES)

set(JSON_TEST_FILES data/script_valid.json data/base58_keys_valid.json data/sig_canonical.json data/sig_noncanonical.json data/base58_encode_decode.json data/base58_keys_invalid.json data/script_invalid.json data/tx_invalid.json data/tx_valid.json)
set(ALERT_TEST_FILES data/alertTests.raw)

# Wrap the raw/json files into byte arrays
foreach(_file ${JSON_TEST_FILES})
    GET_FILENAME_COMPONENT(_abs_file ${_file} ABSOLUTE)
    GET_FILENAME_COMPONENT(_basename ${_file} NAME_WE)
    string(REPLACE ".json" ".json.h" json_h ${_file})
    SET(_json_h ${CMAKE_CURRENT_BINARY_DIR}/${json_h})
    ADD_CUSTOM_COMMAND(OUTPUT ${_json_h}
        COMMAND ${PYTHON_EXECUTABLE}
        ARGS ${CMAKE_SOURCE_DIR}/share/hexdump.py ${_abs_file} ${_json_h} json_tests ${_basename}
        DEPENDS ${_abs_file}
    )
    SET(JSON_TEST_FILE_HEADERS ${JSON_TEST_FILE_HEADERS} ${_json_h})
endforeach()

foreach(_file ${ALERT_TEST_FILES})
    GET_FILENAME_COMPONENT(_abs_file ${_file} ABSOLUTE)
    GET_FILENAME_COMPONENT(_basename ${_file} NAME_WE)
    string(REPLACE ".raw" ".raw.h" raw_h ${_file})
    SET(_raw_h ${CMAKE_CURRENT_BINARY_DIR}/${raw_h})
    ADD_CUSTOM_COMMAND(OUTPUT ${_raw_h}
        COMMAND ${PYTHON_EXECUTABLE}
        ARGS ${CMAKE_SOURCE_DIR}/share/hexdump.py ${_abs_file} ${_raw_h} alert_tests ${_basename}
        DEPENDS ${_abs_file}
    )
    SET(ALERT_TEST_FILE_HEADERS ${ALERT_TEST_FILE_HEADERS} ${_raw_h})
endforeach()

include_directories(.)
include_directories(..)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(test_bitcoin EXCLUDE_FROM_ALL ${TEST_BITCOIN_SOURCES} ${JSON_TEST_FILE_HEADERS} ${ALERT_TEST_FILE_HEADERS})
target_link_libraries(test_bitcoin shlwapi BitcoinCore)

