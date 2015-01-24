module Tab
  module Base
    include Curses

    attr_reader :title

    def initialize
      @window = stdscr.subwin(stdscr.maxy - 5, stdscr.maxx - 30, 3, 0)
    end

    def refresh
      return if @refreshing || closed? || TabManager.instance.current_tab.object_id != object_id

      @refreshing = true
      Thread.new do
        update
        @refreshing = false
      end
    end

    def close
      @window.close
    end

    def respond_to_key(key)
      fail NotImplementedError, 'respond_to_key method must be implemented'
    end

    private

    def update
      fail NotImplementedError, 'update method must be implemented'
    end
  end
end
