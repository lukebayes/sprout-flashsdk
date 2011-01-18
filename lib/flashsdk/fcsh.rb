
module FlashSDK

  class FCSH < Sprout::Executable::Session

    ##
    # The the Ruby file that will load the expected
    # Sprout::Specification.
    #
    # Default value is 'flex4'
    set :pkg_name, 'flex4'

    ##
    # The default pkg version
    #
    set :pkg_version, ">= #{FlashSDK::VERSION}"

    ##
    # The default executable target.
    #
    set :executable, :fcsh

    ##
    # Set the default prompt that should be presented
    #  on stdout when fcsh is ready for input.
    set :prompt, /^\(fcsh\) /

    ##
    # Clear the saved compilation target
    # from memory.
    #
    # @param id [Integer]
    #
    add_action :clear

    ##
    # Perform compilation using COMPC and the
    # provided arguments.
    #
    # @param options [String]
    #
    add_action :compc

    ##
    # Execute a saved compilation from the provided
    # id number.
    #
    # @param id [Integer]
    #
    add_action :compile

    ##
    # Perform compilation using MXMLC and the
    # provided arguments.
    #
    # @param options [String]
    #
    add_action :mxmlc

    ##
    # Exit FCSH
    add_action :quit


    def system_execute binary, params
      params ||= ''
      ##
      # Combine stdout and stderr for FCSH
      # so that they both arrive on stdout
      params << ' 2<&1'
      super binary, params
    end

  end
end

##
# Rake task that will make any subsequent
# mxmlc or compc tasks use the FCSH compiler.
#
# You can use this task by inserting it
# before the task you're calling on the 
# command line like:
#
#   rake fcsh test
#
# or:
#
#   rake fcsh debug
#
# Or you can add this task as a prerequisite
# to your build tasks directly like:
#
#   mxmlc 'bin/SomeProject.swf' => :fcsh do |t|
#     ...
#   end
#
desc "Make subsequent MXMLC or COMPC tasks use FCSH"
task :fcsh do
  ENV['USE_FCSH'] = 'true'
end

##
# Rake task that will make any subsequent
# mxmlc or compc tasks use the FCSH compiler.
#
# You can use this task by inserting it
# before the task you're calling on the 
# command line like:
#
#   rake fcsh test
#
# or:
#
#   rake fcsh debug
#
# Or you can add this task as a prerequisite
# to your build tasks directly like:
#
#   mxmlc 'bin/SomeProject.swf' => :fcsh do |t|
#     ...
#   end
#
desc "Make subsequent MXMLC or COMPC tasks use FCSH"
task :fcsh do
  ENV['USE_FCSH'] = 'true'
end
##
# Rake task that will make any subsequent
# mxmlc or compc tasks use the FCSH compiler.
#
# You can use this task by inserting it
# before the task you're calling on the 
# command line like:
#
#   rake fcsh test
#
# or:
#
#   rake fcsh debug
#
# Or you can add this task as a prerequisite
# to your build tasks directly like:
#
#   mxmlc 'bin/SomeProject.swf' => :fcsh do |t|
#     ...
#   end
#
desc "Make subsequent MXMLC or COMPC tasks use FCSH"
task :fcsh do
  ENV['USE_FCSH'] = 'true'
end

namespace :fcsh do
  desc "Start the FCSH server"
  task :start do
    server = FlashSDK::FCSHSocket.new
    server.listen ENV['FCSH_PKG_NAME'], ENV['FCSH_PKG_VERSION'], ENV['FCSH_PORT']
  end

  desc "Clear the cached compilation data"
  task :clear do
    client = FlashSDK::FCSHSocket.new
    client.execute "clear", ENV['FCSH_PORT']
  end

  desc "Quit the fcsh server"
  task :quit do
    client = FlashSDK::FCSHSocket.new
    client.execute "quit", ENV['FCSH_PORT']
  end
end

