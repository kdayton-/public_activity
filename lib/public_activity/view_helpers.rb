# Provides a shortcut from views to the rendering method.
module PublicActivity
  # Module extending ActionView::Base and adding `render_activity` helper.
  module ViewHelpers
    # View helper for rendering an activity, calls {PublicActivity::Activity#render} internally.
    def render_activity activity, options = {}
      activity.render self, options
    end
    # Helper for setting content_for in activity partial, needed to 
    # flush remains in between partial renders.
    def single_content_for(name, content = nil, &block)
      @view_flow.set(name, ActiveSupport::SafeBuffer.new)
      content_for(name, content, &block)
    end
  end

  ActionView::Base.class_eval { include ViewHelpers }
end
