module FlashSDK

  ##
  # The ACOMPC tool is a wrapper for the acompc tool.
  #
  class ACOMPC < COMPC

    ##
    # The default executable target.
    #
    set :executable, :acompc
    
    ##
    # TODO: Remove this method once this bug is fixed:
    # http://www.pivotaltracker.com/story/show/4194771
    #
    def execute *args
      self.executable = :acompc
      super
    end
  end
end

def acompc args, &block
  exe = FlashSDK::ACOMPC.new
  exe.to_rake(args, &block)
  exe
end

