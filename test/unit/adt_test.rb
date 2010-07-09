require File.join(File.dirname(__FILE__), 'test_helper')

class ADTTest < Test::Unit::TestCase
  include SproutTestCase

  context "An ADT tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'air', 'simple'
      @application_xml = File.join @fixture, 'SomeProject.xml'
      @expected_output = File.join @fixture, 'SomeProject.air'
      @swf_input       = File.join @fixture, 'SomeProject.swf'

      @certificate     = File.join @fixture, 'SomeProject.pfx'
      @cert_password   = 'samplePassword'

      #Sprout::Log.debug = false
    end

    teardown do
      remove_file @expected_output
    end

    should "package a SWF with an application.xml" do
      as_a_unix_system do
        t = adt @expected_output do |t|
          t.package        = true
          t.package_input  = @application_xml
          t.package_output = @expected_output
          t.storetype      = 'PKCS12'
          t.keystore       = @certificate
          t.storepass      = @cert_password
          t.included_files << @swf_input
        end
        t.execute
        assert_file @expected_output
      end
    end

    should "create a self-signed certificate" do
      as_a_unix_system do
        t = adt(@certificate) do |t|
          t.certificate = true
          t.cn          = 'SelfCertificate'
          t.key_type    = '2048-RSA'
          t.pfx_file    = @certificate
          t.password    = @cert_password
        end
        t.execute
        assert_file @certificate
      end
    end

  end
end

