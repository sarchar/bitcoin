find_package(Qt4 COMPONENTS QtCore QtGui QtNetwork REQUIRED)
find_package(Protobuf REQUIRED)

include_directories(.)
include_directories(..)
include_directories(${Boost_INCLUDE_DIR})
include_directories(${QT_QTCORE_INCLUDE_DIR} ${QT_QTGUI_INCLUDE_DIR} ${QT_QTNETWORK_INCLUDE_DIR} ${QT_QTCORE_INCLUDE_DIR}/..)

set(BITCOIN_QT_SOURCES aboutdialog.cpp addressbookpage.cpp addresstablemodel.cpp askpassphrasedialog.cpp bitcoinaddressvalidator.cpp bitcoinamountfield.cpp bitcoin.cpp bitcoingui.cpp bitcoinunits.cpp clientmodel.cpp csvmodelwriter.cpp editaddressdialog.cpp guiutil.cpp intro.cpp monitoreddatamapper.cpp notificator.cpp optionsdialog.cpp optionsmodel.cpp overviewpage.cpp paymentrequestplus.cpp paymentserver.cpp qvalidatedlineedit.cpp qvaluecombobox.cpp rpcconsole.cpp sendcoinsdialog.cpp sendcoinsentry.cpp signverifymessagedialog.cpp splashscreen.cpp transactiondesc.cpp transactiondescdialog.cpp transactionfilterproxy.cpp transactionrecord.cpp transactiontablemodel.cpp transactionview.cpp walletframe.cpp walletmodel.cpp walletmodeltransaction.cpp walletstack.cpp walletview.cpp)
set(BITCOIN_QT_FORMS forms/aboutdialog.ui forms/addressbookpage.ui forms/askpassphrasedialog.ui forms/editaddressdialog.ui forms/intro.ui forms/optionsdialog.ui forms/overviewpage.ui forms/qrcodedialog.ui forms/rpcconsole.ui forms/sendcoinsdialog.ui forms/sendcoinsentry.ui forms/signverifymessagedialog.ui forms/transactiondescdialog.ui)
set(BITCOIN_QT_MOC_HEADERS aboutdialog.h addressbookpage.h addresstablemodel.h askpassphrasedialog.h bitcoinaddressvalidator.h bitcoinamountfield.h bitcoingui.h bitcoinunits.h clientmodel.h csvmodelwriter.h editaddressdialog.h guiutil.h intro.h macdockiconhandler.h macnotificationhandler.h monitoreddatamapper.h notificator.h optionsdialog.h optionsmodel.h overviewpage.h paymentserver.h qvalidatedlineedit.h qvaluecombobox.h rpcconsole.h sendcoinsdialog.h sendcoinsentry.h signverifymessagedialog.h splashscreen.h transactiondesc.h transactiondescdialog.h transactionfilterproxy.h transactiontablemodel.h transactionview.h walletframe.h walletmodel.h walletstack.h walletview.h)
set(BITCOIN_QT_MOC_CPP intro.cpp overviewpage.cpp rpcconsole.cpp)
set(BITCOIN_QT_RESOURCES bitcoin.qrc)
set(BITCOIN_QT_PROTOBUFS paymentrequest.proto)
set(BITCOIN_QT_LOCALES locale/bitcoin_ach.ts locale/bitcoin_af_ZA.ts locale/bitcoin_ar.ts locale/bitcoin_be_BY.ts locale/bitcoin_bg.ts locale/bitcoin_bs.ts locale/bitcoin_ca_ES.ts locale/bitcoin_ca.ts locale/bitcoin_cs.ts locale/bitcoin_cy.ts locale/bitcoin_da.ts locale/bitcoin_de.ts locale/bitcoin_el_GR.ts locale/bitcoin_en.ts locale/bitcoin_eo.ts locale/bitcoin_es_CL.ts locale/bitcoin_es.ts locale/bitcoin_et.ts locale/bitcoin_eu_ES.ts locale/bitcoin_fa_IR.ts locale/bitcoin_fa.ts locale/bitcoin_fi.ts locale/bitcoin_fr_CA.ts locale/bitcoin_fr.ts locale/bitcoin_gu_IN.ts locale/bitcoin_he.ts locale/bitcoin_hi_IN.ts locale/bitcoin_hr.ts locale/bitcoin_hu.ts locale/bitcoin_id_ID.ts locale/bitcoin_it.ts locale/bitcoin_ja.ts locale/bitcoin_kk_KZ.ts locale/bitcoin_ko_KR.ts locale/bitcoin_la.ts locale/bitcoin_lt.ts locale/bitcoin_lv_LV.ts locale/bitcoin_ms_MY.ts locale/bitcoin_nb.ts locale/bitcoin_nl.ts locale/bitcoin_pl.ts locale/bitcoin_pt_BR.ts locale/bitcoin_pt_PT.ts locale/bitcoin_ro_RO.ts locale/bitcoin_ru.ts locale/bitcoin_sk.ts locale/bitcoin_sq.ts locale/bitcoin_sr.ts locale/bitcoin_sv.ts locale/bitcoin_th_TH.ts locale/bitcoin_tr.ts locale/bitcoin_uk.ts locale/bitcoin_vi.ts locale/bitcoin_vi_VN.ts locale/bitcoin_zh_CN.ts locale/bitcoin_zh_TW.ts)

SET(BITCOIN_QT_RES_ICONS res/icons/bitcoin.png res/icons/address-book.png res/icons/quit.png res/icons/send.png res/icons/toolbar.png res/icons/connect0_16.png res/icons/connect1_16.png res/icons/connect2_16.png res/icons/connect3_16.png res/icons/connect4_16.png res/icons/transaction0.png res/icons/transaction2.png res/icons/clock1.png res/icons/clock2.png res/icons/clock3.png res/icons/clock4.png res/icons/clock5.png res/icons/configure.png res/icons/receive.png res/icons/editpaste.png res/icons/editcopy.png res/icons/add.png res/icons/bitcoin_testnet.png res/icons/toolbar_testnet.png res/icons/edit.png res/icons/history.png res/icons/overview.png res/icons/export.png res/icons/synced.png res/icons/remove.png res/icons/tx_mined.png res/icons/tx_input.png res/icons/tx_output.png res/icons/tx_inout.png res/icons/lock_closed.png res/icons/lock_open.png res/icons/key.png res/icons/filesave.png res/icons/qrcode.png res/icons/debugwindow.png res/icons/bitcoin.ico res/icons/bitcoin_testnet.ico)
SET(BITCOIN_QT_RES_IMAGES res/images/about.png res/images/splash.png res/images/splash_testnet.png)
SET(BITCOIN_QT_RES_MOVIES res/movies/update_spinner.mng)

# TODO enable/disable the QRCode sources?
find_package(QREncode)
if(QRENCODE_FOUND)
    set(BITCOIN_QT_SOURCES ${BITCOIN_QT_SOURCES} qrcodedialog.cpp)
    set(BITCOIN_QT_MOC_HEADERS ${BITCOIN_QT_MOC_HEADERS} qrcodedialog.h)
    set(QRENCODE_USE_LIBRARY ${QRENCODE_LIBRARY})
    include_directories(${QRENCODE_INCLUDE_DIRS})
    add_definitions(/DUSE_QRCODE=1)
else()
    MESSAGE(STATUS "*** Not building QREncode dialog!")
    set(QRENCODE_USE_LIBRARY )
endif()

QT4_WRAP_UI(BITCOIN_QT_FORMS_HEADERS ${BITCOIN_QT_FORMS})
QT4_WRAP_CPP(BITCOIN_QT_MOC_SOURCES ${BITCOIN_QT_MOC_HEADERS})
QT4_ADD_RESOURCES(BITCOIN_QT_RESOURCES_SOURCES ${BITCOIN_QT_RESOURCES})

# The CPP files that generate MOC files do not get the moc_ prefix and are instead renamed foo.moc
foreach(_file ${BITCOIN_QT_MOC_CPP})
    GET_FILENAME_COMPONENT(_abs_file ${_file} ABSOLUTE)
    GET_FILENAME_COMPONENT(_basename ${_file} NAME_WE)
    SET(_moc ${CMAKE_CURRENT_BINARY_DIR}/${_basename}.moc)
    ADD_CUSTOM_COMMAND(OUTPUT ${_moc}
        COMMAND ${QT_MOC_EXECUTABLE}
        ARGS ${_abs_file} -o ${_moc}
        DEPENDS ${_abs_file}
    )
    SET(BITCOIN_QT_MOC_SOURCES ${BITCOIN_QT_MOC_SOURCES} ${_moc})
endforeach()

# We need to build foo.pb.h and foo.pb.cc for the protobuf sources
foreach(_file ${BITCOIN_QT_PROTOBUFS})
    GET_FILENAME_COMPONENT(_abs_file ${_file} ABSOLUTE)
    GET_FILENAME_COMPONENT(_abs_path ${_abs_file} PATH)
    GET_FILENAME_COMPONENT(_basename ${_file} NAME_WE)
    SET(_pb_header ${CMAKE_CURRENT_BINARY_DIR}/${_basename}.pb.h)
    SET(_pb_cpp ${CMAKE_CURRENT_BINARY_DIR}/${_basename}.pb.cc)
    ADD_CUSTOM_COMMAND(OUTPUT ${_pb_cpp}
        COMMAND ${GPB_PROTOC}
        ARGS --cpp_out=${CMAKE_CURRENT_BINARY_DIR} --proto_path=${_abs_path} ${_abs_file}
        DEPENDS ${_abs_file}
    )
    SET(BITCOIN_QT_PROTOBUF_SOURCES ${BITCOIN_QT_PROTOBUF_SOURCES} ${_pb_cpp})
endforeach()

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${GPB_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIRS})

include(${QT_USE_FILE})
add_definitions(${QT_DEFINITIONS})

add_executable(BitcoinQt WIN32 ${BITCOIN_QT_SOURCES} ${BITCOIN_QT_FORMS_HEADERS} ${BITCOIN_QT_MOC_SOURCES} ${BITCOIN_QT_PROTOBUF_SOURCES} ${BITCOIN_QT_RESOURCES_SOURCES})

# We need to build the qm files from the ts sources
# This is frustrating that Qt4's RCC doesn't have any search path 
# arguments/parameters
FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/locale)
foreach(_file ${BITCOIN_QT_LOCALES})
    GET_FILENAME_COMPONENT(_abs_file ${_file} ABSOLUTE)
    string(REPLACE ".ts" ".qm" qm_file ${_file})
    SET(_qm_file ${CMAKE_CURRENT_SOURCE_DIR}/${qm_file})
    ADD_CUSTOM_COMMAND(TARGET BitcoinQt PRE_BUILD
        COMMAND ${QT_LRELEASE_EXECUTABLE}
        ARGS ${_abs_file} -qm ${_qm_file}
        DEPENDS ${_abs_file}
    )
    SET(BITCOIN_QT_LOCALE_SOURCES ${BITCOIN_QT_LOCALE_SOURCES} ${_qm_file})
endforeach()

target_link_libraries(BitcoinQt BitcoinCore shlwapi ${QT_QTGUI_LIBRARY} ${QT_QTCORE_LIBRARY} ${QT_QTNETWORK_LIBRARY} ${QT_QTMAIN_LIBRARY} ${GPB_LIBRARY} ${QRENCODE_USE_LIBRARY})
install(TARGETS BitcoinQt DESTINATION .)
