require File.join(File.dirname(__FILE__), 'test_helper')

class ADTTest < Test::Unit::TestCase
  include SproutTestCase

  context "An ADT tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'air', 'simple'
      @application_xml = File.join(@fixture, 'SomeProject.xml')
      @expected_output = File.join(@fixture, 'SomeProject.air')
      @swf_input       = File.join(@fixture, 'SomeProject.swf')

      @certificate     = File.join(@fixture, 'SomeProject.pfx')
      @cert_password   = 'samplePassword'

      Sprout::Log.debug = false
    end

    teardown do
      remove_file @expected_output
    end

    should "package a SWF with an application.xml" do
      as_a_unix_system do
        adt                = FlashSDK::ADT.new
        adt.package        = true
        adt.package_input  = @application_xml
        adt.package_output = @expected_output
        #adt.key_type       = 'pfx'
        #adt.pfx_file       = @certificate
        adt.storetype      = 'PKCS12'
        adt.keystore       = @certificate
        adt.storepass       = @cert_password
        adt.included_files << @swf_input
        #assert_equal "-package #{@expected_output} #{@application_xml} #{@swf_input} -storetype pkcs12 -keystore #{@certificate}", adt.to_shell

        adt.execute
        assert_file @expected_output
      end
    end

    should "create a self-signed certificate" do
      as_a_unix_system do
        t = adt @certificate do |t|
          t.certificate = true
          t.cn          = 'SelfCertificate'
          t.key_type    = '1024-RSA'
          t.password    = @cert_password
          t.pfx_file    = @certificate
        end
        t.execute
      end
    end

  end
end

