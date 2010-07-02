
Sprout::Specification.new do |s|
  s.name    = 'flex3'
  s.version = FlashSDK::VERSION

  # Create an independent remote_file_target for each
  # platform that must be supported independently.
  #
  # If the archive includes support for all platforms (:windows, :osx, :unix)
  # then set platform = :universal
  #
  s.add_remote_file_target do |t|
    # Apply the windows-specific configuration:
    t.platform = :universal
    # Apply the shared platform configuration:
    # Remote Archive:
    t.archive_type = :zip
    t.url          = "http://fpdownload.adobe.com/pub/flex/sdk/builds/flex3/flex_sdk_3.4.0.9271_mpl.zip"
    t.md5          = "ba0df5a5b7a9c901540bedaf8a4fec9e"

    # Executables: (add .exe suffix if it was passed in)
    t.add_executable :aasdoc,     "bin/aasdoc"
    t.add_executable :acompc,     "bin/acompc"
    t.add_executable :adl,        "bin/adl"
    t.add_executable :adt,        "bin/adt"
    t.add_executable :amxmlc,     "bin/amxmlc"
    t.add_executable :asdoc,      "bin/asdoc"
    t.add_executable :compc,      "bin/compc"
    t.add_executable :copylocale, "bin/compc"
    t.add_executable :digest,     "bin/digest"
    t.add_executable :fcsh,       "bin/fcsh"
    t.add_executable :fdb,        "bin/fdb"
    t.add_executable :mxmlc,      "bin/mxmlc"
    t.add_executable :optimizer,  "bin/optimizer"

    # Flex framework SWCs:
    t.add_library :flex,            "frameworks/libs/flex.swc"
    t.add_library :framework,       "frameworks/libs/framework.swc"
    t.add_library :rpc,             "frameworks/libs/rpc.swc"
    t.add_library :utilities,       "frameworks/libs/utilities.swc"
    t.add_library :playerglobal_9,  "frameworks/libs/player/9/playerglobal.swc"
    t.add_library :playerglobal_10, "frameworks/libs/player/10/playerglobal.swc"

    # AsDoc templates:
    t.add_library :asdoc_templates, "asdoc/templates"

    # Locale-Specific Flex SWCs:
    t.add_library :airframework_en_US, "frameworks/locale/en_US/airframework_rb.swc"
    t.add_library :framework_en_US, "frameworks/locale/en_US/framework_rb.swc"
    t.add_library :rpc_en_US, "frameworks/locale/en_US/rpc_rb.swc"
  end
end

