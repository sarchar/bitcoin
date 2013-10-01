add_definitions(/DUNICODE /DWIN32_LEAN_AND_MEAN)

find_package(Boost COMPONENTS system filesystem thread REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(bdb REQUIRED)

add_definitions(/DHAVE_WORKING_BOOST_SLEEP=1 /wd4996 /wd4503 /wd4345 /wd4290)

add_subdirectory(LevelDB)

include_directories(${Boost_INCLUDE_DIR})
include_directories(${OPENSSL_INCLUDE_DIR})
include_directories(${BDB_INCLUDE_DIR})
include_directories(./LevelDB/include)
include_directories(./LevelDB/helpers)
link_directories(${Boost_LIBRARY_DIRS})

add_library(BitcoinCore addrman.cpp key.cpp rpcnet.cpp alert.cpp keystore.cpp rpcrawtransaction.cpp leveldb.cpp rpcwallet.cpp bitcoinrpc.cpp main.cpp script.cpp bloom.cpp miner.cpp chainparams.cpp net.cpp txdb.cpp checkpoints.cpp netbase.cpp util.cpp core.cpp noui.cpp version.cpp crypter.cpp protocol.cpp wallet.cpp db.cpp rpcblockchain.cpp walletdb.cpp hash.cpp rpcdump.cpp init.cpp rpcmining.cpp ${LEVELDB_SOURCES})
target_link_libraries(BitcoinCore ${Boost_FILESYSTEM_LIBRARY} ${Boost_SYSTEM_LIBRARY} ${Boost_THREAD_LIBRARY} ${BDB_LIBRARY} LevelDB optimized ${SSL_EAY_RELEASE} ${LIB_EAY_RELEASE} debug ${SSL_EAY_DEBUG} ${LIB_EAY_DEBUG})
add_subdirectory(Qt)

add_executable(Bitcoind WIN32 bitcoind.cpp)
target_link_libraries(Bitcoind shlwapi BitcoinCore)
set_target_properties(Bitcoind PROPERTIES LINK_FLAGS_RELEASE "/SUBSYSTEM:CONSOLE")
set_target_properties(Bitcoind PROPERTIES LINK_FLAGS_DEBUG "/SUBSYSTEM:CONSOLE")
set_target_properties(Bitcoind PROPERTIES LINK_FLAGS_MINSIZEREL "/SUBSYSTEM:CONSOLE")
set_target_properties(Bitcoind PROPERTIES LINK_FLAGS_RELWITHDEBINFO "/SUBSYSTEM:CONSOLE")
set_target_properties(Bitcoind PROPERTIES COMPILE_DEFINITIONS_DEBUG "_CONSOLE")
set_target_properties(Bitcoind PROPERTIES COMPILE_DEFINITIONS_RELWITHDEBINFO "_CONSOLE")

install(TARGETS Bitcoind DESTINATION .)

add_subdirectory(test)

