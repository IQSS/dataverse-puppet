# dirname(string) : string
# dirname(string[]) : string[]
#
# Returns the directory name.
module Puppet::Parser::Functions
  newfunction(:dirname, :type => :rvalue) do |args|
    if args[0].is_a?(Array)
      args.collect do |a| File.dirname(a) end
    else
      File.dirname(args[0])
    end
  end
end