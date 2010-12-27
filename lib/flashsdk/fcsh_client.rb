
module FlashSDK

  class FCSHClient

    def execute executable, path, command
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

