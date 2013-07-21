manuable_root = '/home/goreorto/rails_apps/manuable'
# manuable_root = '/home/goreorto/workspace/manuable'

God::Watch.class_eval do
  attr_accessor :unix_socket
end

module God
  module Behaviors
    class CleanUnixSocket < Behavior
      def valid?
        valid = true
        if self.watch.unix_socket.nil?
          valid &= complain("Attribute 'unix_socket' must be specified", self)
        end
        valid
      end
      def before_start
        File.delete(self.watch.unix_socket)
        "deleted unix socket"
      rescue
        "no unix socket to delete"
      end
    end
  end
end


God.contact(:email) do |c|
  c.name = 'cesar'
  c.group = 'developers'
  c.to_email = 'cesar@letwrong.com'
end

God.watch do |w|
  w.uid = 'goreorto'
  w.gid = 'goreorto'
  w.name = 'manuable-webapp'
  w.interval = 30.seconds
  w.start = "#{manuable_root}/start_server.sh"
  w.stop = "#{manuable_root}/stop_server"
  w.start_grace = 30.seconds
  w.restart_grace = 30.seconds
  w.log = "#{manuable_root}/log/manuable-wepapp.god.log"
  w.pid_file = "#{manuable_root}/tmp/pids/server.pid"
  w.behavior(:clean_pid_file)

  w.unix_socket = "/tmp/manuable-app.sock"
  w.behavior(:clean_unix_socket)

  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'cesar'
    end
  end
end
