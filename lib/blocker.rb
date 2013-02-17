# -*- encoding : utf-8 -*-

require "blocker/version"

class Blocker
  DEFAULT_LOCK_TIME = 12.hour
  KEY_PREFIX = "#{Conf.redis['namespace'] || ''}:blocker"

  class AccessShareError < StandardError
  end

  class << self
    def lock(name, max_lock_time = DEFAULT_LOCK_TIME, &block)
      raise AccessShareError, "Lock already installed for resource name `#{name}`" if locked?(name)

      _name = key(name)
      redis.set(_name, 1)

      if max_lock_time.is_a?(Time)
        redis.expireat(_name, max_lock_time.to_i)
      else
        redis.expire(_name, max_lock_time)
      end

      ret = nil
      if block_given?
        begin
          ret = block.call
        ensure
          unlock(name)
        end
      end
      ret
    end

    def unlock(name)
      redis.del(key(name))
    end

    def locked?(name)
      redis.exists(key(name))
    end

    def reconnect!
      redis.client.reconnect
    end

    def get_locked
      redis.keys(key('*'))
    end

    def unlock_all
      get_locked.each do |k|
        redis.del(k)
      end
    end

    protected

    def method_missing(m, *args, &block)
      case m.id2name
        when /^lock_(.+)/ then return lock($1, *args, &block)
        when /^unlock_(.+)/ then return unlock($1)
        when /^(.+)_locked\?$/ then return locked?($1, *args)
      end

      raise NoMethodError
    end

    def redis
      if @redis
        return @redis
      else
        return @redis ||= $redis if defined?($redis) && $redis.is_a?(::Redis)
        @redis = ::Redis.new(Conf.redis.dup.symbolize_keys)
        $redis = @redis
      end
    end

    def key(name)
      "#{KEY_PREFIX}:#{name}"
    end
  end

end
