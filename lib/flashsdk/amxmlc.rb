module FlashSDK

  ##
  # This is a wrapper for the AIR MXMLC compiler.
  class AMXMLC < MXMLC
    include Sprout::Executable

    ##
    # The default executable target.
    #
    set :executable, :amxmlc

    ##
    # TODO: Remove this method once this bug is fixed:
    # http://www.pivotaltracker.com/story/show/4194771
    #
    def execute *args
      self.executable = :amxmlc
      super
    end
  end
end

def amxmlc args, &block
  exe = FlashSDK::AMXMLC.new
  exe.to_rake(args, &block)
  exe
end

