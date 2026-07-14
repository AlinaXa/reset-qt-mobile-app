cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(ResetApp VERSION 1.0.0 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

find_package(Qt6 6.8 REQUIRED COMPONENTS
    Core
    Gui
    Widgets
    Qml
    Quick
    QuickTimeline
    ShaderTools
    Sql
)

qt_standard_project_setup()

qt_add_executable(${CMAKE_PROJECT_NAME})

if (ANDROID)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
        QT_ANDROID_PACKAGE_NAME "com.maevitr.reset"
        QT_ANDROID_APP_NAME "RESET"
        QT_ANDROID_APP_ICON "@drawable/reseticon"
        QT_ANDROID_VERSION_NAME "1.0.0"
        QT_ANDROID_VERSION_CODE 1
    )
endif()

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE
        Qt6::Sql
)

qt_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

include(qds)

if (BUILD_QDS_COMPONENTS)
    include(qmlcomponents OPTIONAL)
endif()

if (LINK_INSIGHT)
    include(insight OPTIONAL)
endif()

# QML LocalStorage uses Qt SQL at runtime. On Android the SQLite driver is a
# plugin, so it must be explicitly copied into the package's plugin tree.
if (ANDROID)
    if (NOT TARGET Qt6::QSQLiteDriverPlugin)
        message(FATAL_ERROR
            "Qt's SQLite driver plugin target is missing. "
            "Install the Qt SQL SQLite driver for this Android kit."
        )
    endif()

    set(RESET_ANDROID_PLUGIN_ROOT
        "${CMAKE_CURRENT_BINARY_DIR}/android-extra-plugins"
    )
    set(RESET_ANDROID_SQLDRIVER_DIR
        "${RESET_ANDROID_PLUGIN_ROOT}/plugins/sqldrivers"
    )

    add_custom_command(
        TARGET ${CMAKE_PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory
            "${RESET_ANDROID_SQLDRIVER_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "$<TARGET_FILE:Qt6::QSQLiteDriverPlugin>"
            "${RESET_ANDROID_SQLDRIVER_DIR}/"
        COMMENT "Bundling the QSQLITE driver for Android"
        VERBATIM
    )

    set_property(
        TARGET ${CMAKE_PROJECT_NAME}
        APPEND PROPERTY QT_ANDROID_EXTRA_PLUGINS
        "${RESET_ANDROID_PLUGIN_ROOT}/plugins"
    )
endif()

include(GNUInstallDirs)
install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
