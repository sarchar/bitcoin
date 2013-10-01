include_directories(.)
include_directories(./include)

add_definitions(/DLEVELDB_PLATFORM_WINDOWS)

set(LEVELDB_SOURCES db/builder.cc db/dbformat.cc db/db_bench.cc db/db_impl.cc db/db_iter.cc db/filename.cc db/log_reader.cc db/log_writer.cc db/memtable.cc db/repair.cc db/table_cache.cc db/version_edit.cc db/version_set.cc db/write_batch.cc) 
set(LEVELDB_UTIL_SOURCES util/status.cc util/env.cc util/env_win.cc util/arena.cc util/bloom.cc util/cache.cc util/coding.cc util/comparator.cc util/crc32c.cc util/hash.cc util/options.cc util/filter_policy.cc util/logging.cc util/histogram.cc util/testutil.cc)
set(LEVELDB_MEMENV_SOURCES helpers/memenv/memenv.cc)
set(LEVELDB_PORT_SOURCES port/port_win.cc)
set(LEVELDB_TABLE_SOURCES table/block.cc table/block_builder.cc table/filter_block.cc table/format.cc table/merger.cc table/iterator.cc table/table.cc table/table_builder.cc table/two_level_iterator.cc)

add_library(LevelDB ${LEVELDB_SOURCES} ${LEVELDB_UTIL_SOURCES} ${LEVELDB_MEMENV_SOURCES} ${LEVELDB_PORT_SOURCES} ${LEVELDB_TABLE_SOURCES})

