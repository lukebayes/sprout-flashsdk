
Sprout::Specification.new do |s|
  # This is the Specification that loads the Flex 4 SDK,
  # To use the Flex 4 SDK from your build tasks, you can
  # simply update the pkg_name parameter of your build
  # task as follows:
  #
  #   mxmlc 'bin/SomeProject.swf' do |t|
  #     t.input       = 'src/SomeProject.as'
  #     t.pkg_name    = 'flex4'
  #   end
  #
  # If you'd like to consume any of the libraries that
  # are included with the Flex SDK, you can embed them
  # from your Rakefile as follows:
  #
  #   library :f_textlayout
  #
  #   mxmlc 'bin/SomeProject.swf' => :f_textlayout do |t|
  #     t.input = 'src/SomeProject.as'
  #   end
  #
  # If you'd like to consume one of the localized frameworks
  # you can set that up as follows:
  #
  #   library 'flex_4_es_ES'
  #
  #   mxmlc 'bin/SomeProject.swf' => 'flex_4_es_ES' do |t|
  #     t.input = 'src/SomeProject.as'
  #   end
  #
  s.name    = 'flex4'
  s.version = '4.6.0.23201'

  s.add_remote_file_target do |t|
    t.platform     = :universal
    t.archive_type = :zip
    t.url = "http://download.macromedia.com/pub/flex/sdk/flex_sdk_4.6.zip"
    t.md5 = "202bca98ee7b8db9cda3af01e99c688e"

    # Executables: (add .exe suffix if it was passed in)
    t.add_executable :aasdoc,     "bin/aasdoc"
    t.add_executable :acompc,     "bin/acompc"
    t.add_executable :adl,        "bin/adl"
    t.add_executable :adt,        "bin/adt"
    t.add_executable :amxmlc,     "bin/amxmlc"
    t.add_executable :asdoc,      "bin/asdoc"
    t.add_executable :compc,      "bin/compc"
    t.add_executable :copylocale, "bin/copylocale"
    t.add_executable :digest,     "bin/digest"
    t.add_executable :fcsh,       "bin/fcsh"
    t.add_executable :fdb,        "bin/fdb"
    t.add_executable :mxmlc,      "bin/mxmlc"
    t.add_executable :optimizer,  "bin/optimizer"

    # Flex framework SWCs:
    t.add_library :advancedgrids,           "frameworks/libs/advancedgrids.swc"
    t.add_library :aircore,                 "frameworks/libs/air/aircore.swc"
    t.add_library :airframework,            "frameworks/libs/air/airframework.swc"
    t.add_library :airglobal,               "frameworks/libs/air/airglobal.swc"
    t.add_library :airspark,                "frameworks/libs/air/airspark.swc"
    t.add_library :applicationupdater,      "frameworks/libs/air/applicationupdater.swc"
    t.add_library :applicationupdater_ui,   "frameworks/libs/air/applicationupdater_ui.swc"
    t.add_library :automation,              "frameworks/libs/automation/automation.swc"
    t.add_library :automation_agent,        "frameworks/libs/automation/automation_agent.swc"
    t.add_library :automation_air,          "frameworks/libs/automation/automation_air.swc"
    t.add_library :automation_airspark,     "frameworks/libs/automation/automation_airspark.swc"
    t.add_library :automation_dmv,          "frameworks/libs/automation/automation_dmv.swc"
    t.add_library :automation_flashflexkit, "frameworks/libs/automation/automation_flashflexkit.swc"
    t.add_library :automation_spark,        "frameworks/libs/automation/automation_spark.swc"
    t.add_library :qtp,                     "frameworks/libs/automation/qtp.swc"
    t.add_library :qtp_air,                 "frameworks/libs/automation/qtp_air.swc"
    t.add_library :servicemonitor,          "frameworks/libs/air/servicemonitor.swc"
    t.add_library :authoringsupport,        "frameworks/libs/authoringsupport.swc"
    t.add_library :charts,                  "frameworks/libs/charts.swc"
    t.add_library :core,                    "frameworks/libs/core.swc"
    t.add_library :flash_integration,       "frameworks/libs/flash-integration.swc"
    t.add_library :framework,               "frameworks/libs/framework.swc"
    t.add_library :mobilecomponents,        "frameworks/libs/mobile/mobilecomponents.swc"
    t.add_library :mx,                      "frameworks/libs/mx/mx.swc"
    t.add_library :osmf,                    "frameworks/libs/osmf.swc"
    t.add_library :playerglobal_11,         "frameworks/libs/player/11.1/playerglobal.swc"
    t.add_library :rpc,                     "frameworks/libs/rpc.swc"
    t.add_library :spark,                   "frameworks/libs/spark.swc"
    t.add_library :spark_dmv,               "frameworks/libs/spark_dmv.swc"
    t.add_library :sparkskins,              "frameworks/libs/sparkskins.swc"
    t.add_library :textLayout,              "frameworks/libs/textLayout.swc"

    # AsDoc templates:
    t.add_library :asdoc_templates, "asdoc/templates"

    # Locale-Specific Flex SWCs:
    [
      'da_DK', 'de_DE', 'en_US', 'es_ES', 'fi_FL', 'fr_FR', 'it_IT', 'ja_JP',
      'ko_KR', 'nb_NO', 'nl_NL', 'pt_BR', 'ru_RU', 'sv_SE', 'zh_CN', 'zh_TW'
    ].each do |locale|
      t.add_library "advancedgrids_#{locale}".to_sym,     "frameworks/locale/#{locale}/advancedgrids_rb.swc"
      t.add_library "airframework_#{locale}".to_sym,      "frameworks/locale/#{locale}/airframework_rb.swc"
      t.add_library "airspark_#{locale}".to_sym,          "frameworks/locale/#{locale}/airspark_rb.swc"
      t.add_library "automation_agent_#{locale}".to_sym,  "frameworks/locale/#{locale}/automation_agent_rb.swc"
      t.add_library "automation_#{locale}".to_sym,        "frameworks/locale/#{locale}/automation_rb.swc"
      t.add_library "charts_#{locale}".to_sym,            "frameworks/locale/#{locale}/charts_rb.swc"
      t.add_library "flash_integration_#{locale}".to_sym, "frameworks/locale/#{locale}/flash-integration_rb.swc"
      t.add_library "framework_#{locale}".to_sym,         "frameworks/locale/#{locale}/framework_rb.swc"
      t.add_library "mobilecomponents_#{locale}".to_sym,  "frameworks/locale/#{locale}/mobilecomponents_rb.swc"
      t.add_library "mx_#{locale}".to_sym,                "frameworks/locale/#{locale}/mx_rb.swc"
      t.add_library "osmf_#{locale}".to_sym,              "frameworks/locale/#{locale}/osmf_rb.swc"
      t.add_library "playerglobal_#{locale}".to_sym,      "frameworks/locale/#{locale}/playerglobal_rb.swc"
      t.add_library "qtp_air_#{locale}".to_sym,           "frameworks/locale/#{locale}/qtp_air_rb.swc"
      t.add_library "rpc_#{locale}".to_sym,               "frameworks/locale/#{locale}/rpc_rb.swc"
      t.add_library "spark_#{locale}".to_sym,             "frameworks/locale/#{locale}/spark_rb.swc"
      t.add_library "textLayout_#{locale}".to_sym,        "frameworks/locale/#{locale}/textLayout_rb.swc"
    end
  end
end
