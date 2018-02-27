# encoding: utf-8

module TuneMyGc
  module Spies
    class Grape < TuneMyGc::Spies::Base
      def install
        # ::Grape::API.__send__(:use, GrapeMiddleware)
        GrapeMiddleware.enabled = true
        TuneMyGc.log "hooked: grape"
      end

      def uninstall
        GrapeMiddleware.enabled = false
        TuneMyGc.log "uninstalled grape spy"
      end
    end

    class GrapeMiddleware < ::Grape::Middleware::Base
      @enabled = false
      class << self
        attr_accessor :enabled
      end

      def before
        if self.class.enabled
          TuneMyGc.processing_started
          # TuneMyGc.log "PROCESSING_STARTED"
        end
      end

      def after
        if self.class.enabled
          TuneMyGc.processing_ended
          # TuneMyGc.log "PROCESSING_ENDED"
        end
        return nil
      end
    end
  end
end

